// Connect Four
// vr 20 december 2024
// Initial game state
// STILL TO DO:
// - Run Batch, get the proper simulations for both players, see Batch Simulation Implementation!!
// - Run Batch, clean up button text after done.

const gameState = {
    board: Array.from({ length: 6 }, () => Array(7).fill(null)), // 6x7 empty board
    moveHistory: [],
    currentTurn: 'red',
    gameOver: false,
    note: '' // New note field in the game state
};

const strategies = {
  randomStrategy,
  mimicOpponentStrategy,
  threatBasedStrategy,
  threatOrRandomStrategy,
  preferMiddleStrategy,
};

let globalred = 0;
let globalblack = 0;
let cumulativeGameStates = ''; // Stores all game states for moves

// DOM Elements
const boardElement = document.getElementById('board');
const moveInput = document.getElementById('moveInput');
const exportBtn = document.getElementById('exportBtn');
const importBtn = document.getElementById('importBtn');
const clearBtn = document.getElementById('clearBtn');
const clearThreatsBtn = document.getElementById('clearThreatsBtn');
const fileInput = document.getElementById('fileInput');
const simulateBtn = document.getElementById('simulateBtn');
const moveLbl = document.getElementById('moveInputLbl');
const redCountEl   = document.getElementById('redCount');
const blackCountEl = document.getElementById('blackCount');
const currentTurnEl = document.getElementById('currentTurn');

// Initialize Board UI
function createBoardUI() {
    boardElement.innerHTML = '';
    for (let row = 0; row < 6; row++) {
        for (let col = 0; col < 7; col++) {
            const cell = document.createElement('div');
            cell.classList.add('cell');
            cell.dataset.row = row;
            cell.dataset.column = col;
            boardElement.appendChild(cell);
        }
    }
}

// Update UI for a move
function updateUI(row, column, color, moveNumber) {
    const cell = boardElement.querySelector(`[data-row="${row}"][data-column="${column}"]`);
    const piece = document.createElement('div');
    piece.classList.add('piece', color);

    const moveLabel = document.createElement('span');
    moveLabel.textContent = moveNumber;
    piece.appendChild(moveLabel);

    cell.appendChild(piece);
    moveLbl.textContent =`Next move: (${moveNumber + 1})`;
}

// Clear UI for a cell
function clearUIAt(row, column) {
    const cell = boardElement.querySelector(`[data-row="${row}"][data-column="${column}"]`);
    cell.innerHTML = ''; // Clear the cell content
}

// Find the lowest empty cell in a column
function findLowestEmptyCell(column) {
    for (let row = 5; row >= 0; row--) {
        if (gameState.board[row][column] === null) {
            return { row, column };
        }
    }
    return null;
}

function updatePlayerTurn() {
  const playerTurnEl = document.getElementById('playerTurn');
  const { red, black } = updateCounters();

  // 1) Update the big “RED” / “BLACK” word and its class
  currentTurnEl.textContent = gameState.currentTurn.toUpperCase();
// Remove any old color classes…
currentTurnEl.classList.remove('red', 'black');
// …then add the new one
currentTurnEl.classList.add(gameState.currentTurn);

  // 2) Update the counts (you should already be calling updateCounters() elsewhere)
  redCountEl.textContent   = red;
  blackCountEl.textContent = black;
}

// Recompute counts from gameState.board and update the DOM
function updateCounters() {
  let red = 0, black = 0;
  for (let r = 0; r < 6; r++) {
    for (let c = 0; c < 7; c++) {
      if (gameState.board[r][c] === 'red') red++;
      else if (gameState.board[r][c] === 'black') black++;
    }
  }
  redCountEl.textContent = red;
  blackCountEl.textContent = black;
  return { red, black };
}

// Undo the last move
function undoLastMove() {
    const lastMove = gameState.moveHistory.pop();
    if (lastMove) {
        const { row, column, color } = lastMove;
        gameState.board[row][column] = null;
        clearUIAt(row, column);
        gameState.currentTurn = color;
        updateCounters();
        updatePlayerTurn();
    } else {
        alert('No moves to undo!');
    }
}

// Handle Move Input (via Input Field)
moveInput.addEventListener('input', (event) => {
    const input = event.target.value.toUpperCase(); 
    if (input === '-') {
        undoLastMove();
    } else if (/^[A-G]$/.test(input)) {
        const column = input.charCodeAt(0) - 'A'.charCodeAt(0);
        placePieceInColumn(column);
    } else {
        alert('Invalid input. Enter A-G for columns or "-" to undo.');
    }

    moveInput.value = ''; // Clear input
});

// Handle Move Input (via Cell Click)
boardElement.addEventListener('click', (event) => {
    const clickedCell = event.target.closest('.cell');
    if (!clickedCell) return;

    const column = parseInt(clickedCell.dataset.column, 10);
    placePieceInColumn(column);
});

// Export Game State
exportBtn.addEventListener('click', () => {
    const fileNameInput = document.getElementById('fileNameInput');
    let fileName = fileNameInput && fileNameInput.value.trim() ? fileNameInput.value.trim() : 'board_positions';
    if (!fileName.endsWith('.json')) fileName += '.json';
    const data = JSON.stringify(gameState); // Export the entire gameState (including the note)
    downloadFile(data, fileName, 'application/json');
});

// Utility function to download a file
function downloadFile(content, fileName, fileType) {
    const blob = new Blob([content], { type: fileType });
    const url = URL.createObjectURL(blob);
    const a = document.createElement('a');
    a.href = url;
    a.download = fileName;
    a.click();
    URL.revokeObjectURL(url);
}

// Import Game State
importBtn.addEventListener('click', () => {
    fileInput.click();
});

fileInput.addEventListener('change', (event) => {
    const file = event.target.files[0];
    if (file) {
        const reader = new FileReader();
        reader.onload = () => {
            try {
                const importedState = JSON.parse(reader.result); // Parse JSON file content
                loadGameState(importedState); // Load game state

                // Set the imported file name (without extension) in the fileNameInput field
                const fileNameWithoutExtension = file.name.replace(/\.[^/.]+$/, '');
                const fileNameInput = document.getElementById('fileNameInput');
                if (fileNameInput) {
                    fileNameInput.value = fileNameWithoutExtension;
                }
            } catch (error) {
                // alert('Invalid file format. Please select a valid JSON file.');
            }
        };
        reader.readAsText(file); // Read the file as text
    }
});


function createRowLabels() {
    const rowLabelsContainer = document.getElementById('row-labels');
    rowLabelsContainer.innerHTML = ''; // Clear existing labels
    for (let i = 6; i >= 1; i--) {
        const label = document.createElement('div');
        label.textContent = i;
        rowLabelsContainer.appendChild(label);
    }
}

function createColumnLabels() {
    const colLabelsContainer = document.getElementById('col-labels');
    colLabelsContainer.innerHTML = ''; // Clear existing labels
    const columnLetters = ['A', 'B', 'C', 'D', 'E', 'F', 'G'];
    columnLetters.forEach(letter => {
        const label = document.createElement('div');
        label.textContent = letter;
        colLabelsContainer.appendChild(label);
    });
}

clearThreatsBtn.addEventListener('click', () => {
    clearThreats();
});

// Function to load the game state from the imported JSON file
function loadGameState(importedState) {
    // Reset current game state
    gameState.board = Array.from({ length: 6 }, () => Array(7).fill(null));
    gameState.moveHistory = [];
    gameState.currentTurn = importedState.currentTurn || 'red';
    gameState.gameOver = importedState.gameOver || false;
    gameState.note = importedState.note || ''; // Ensure compatibility with older JSON files

    // Set the note in the note textarea
    document.getElementById('gameNote').value = gameState.note;

    // Reset the UI
    createBoardUI();
    createRowLabels();
    createColumnLabels();

    // Load moves from the imported state
    importedState.moveHistory.forEach((move, index) => {
        const { row, column, color } = move;
        gameState.board[row][column] = color; // Update board data
        gameState.moveHistory.push(move); // Push move into move history
        updateUI(row, column, color, index + 1); // Update the visual board
        updateCounters();
        updatePlayerTurn();
    });

    // Calculate the player turn based on the number of pieces
    calculatePlayerTurn();
    updatePlayerTurn();

    // Check for a winner and update the game over status
    const winner = detectWinner();
    if (winner) {
        gameState.gameOver = true;

        // Update the player turn indicator and board UI before showing the alert
        updatePlayerTurn();
        updateBoardUI();

        // Delay the alert to ensure the UI is updated first
        setTimeout(() => {
            alert(`Player ${winner.toUpperCase()} wins!`);
        }, 100); // 100ms delay

        gameState.currentTurn = winner; // Set the winner as the current turn
    } else {
        // Switch the turn to the other player
        gameState.currentTurn = color === 'red' ? 'black' : 'red';
        updatePlayerTurn();
    }
    updateCounters(); 
    moveInput.focus();
}

// Display a win message below the board
function displayWinMessage(winner) {
    const winMessageElement = document.getElementById('winMessage');
    winMessageElement.textContent = `${winner.toUpperCase()} wins with 4 in a row!`;
    winMessageElement.classList.add('active');
}

// Check for win and set game over if 4-in-a-row is detected
function checkForWin() {
    const winner = detectWinner();
    if (winner) {
        gameState.gameOver = true;
        gameState.currentTurn = winner; // Set the winner as the current turn
        updatePlayerTurn();
        return true;
    }
    return false;
}

// Function to detect a winner (4 consecutive pieces)
function detectWinner() {
    const directions = [
        { row: 0, col: 1 },  // Horizontal
        { row: 1, col: 0 },  // Vertical
        { row: 1, col: 1 },  // Diagonal down-right
        { row: 1, col: -1 }  // Diagonal down-left
    ];

    for (let row = 0; row < 6; row++) {
        for (let col = 0; col < 7; col++) {
            const color = gameState.board[row][col];
            if (!color) continue;

            for (const { row: dr, col: dc } of directions) {
                let count = 1;
                for (let i = 1; i < 4; i++) {
                    const r = row + dr * i;
                    const c = col + dc * i;
                    if (r < 0 || r >= 6 || c < 0 || c >= 7) break;
                    if (gameState.board[r][c] === color) {
                        count++;
                    } else {
                        break;
                    }
                    if (count === 4) {
                        return color; // Return the winner (red or black)
                    }
                }
            }
        }
    }
    return null;
}

function placePieceInColumn(column) {
    const lowestCell = findLowestEmptyCell(column);
    if (lowestCell) {
        const { row, column } = lowestCell;
        const color = gameState.currentTurn; // 'red' or 'black'

        // Update the game state
        gameState.board[row][column] = color;
        gameState.moveHistory.push({ row, column, color });

        // Register the move in the gameNote
        const gameNote = document.getElementById('gameNote');
        const columnLetter = String.fromCharCode(65 + column); // Convert 0-6 to A-G
        const move = color === 'red' ? columnLetter : columnLetter.toLowerCase();
        gameNote.value += `${move}${6 - row} `; // Append the move to the gameNote with a space

        // Update the UI
        updateUI(row, column, color, gameState.moveHistory.length);
        updateCounters();
        updatePlayerTurn();

        // Check for a win
        const winner = detectWinner();
        if (winner) {
            gameState.gameOver = true;
        
            // Update the player turn indicator and board UI before showing the alert
            updatePlayerTurn();
            updateBoardUI();
        
            // Delay the alert to ensure the UI is updated first
            setTimeout(() => {
                alert(`Player ${winner.toUpperCase()} wins!`);
            }, 100); // 100ms delay
        } else {
            // Switch the turn to the other player
            gameState.currentTurn = color === 'red' ? 'black' : 'red';
            updatePlayerTurn();
        }
    
    } else {
        alert('Column is full!');
    }
}


// Reset the game state to its initial state
function resetGame() {
    // Reset game state
    gameState.board = Array.from({ length: 6 }, () => Array(7).fill(null)); // 6x7 empty board
    gameState.moveHistory = [];
    gameState.currentTurn = 'red';
    gameState.gameOver = false;

    // Reset the UI
    createBoardUI(); // Recreate the board cells
    createRowLabels(); // Recreate row labels
    createColumnLabels(); // Recreate column labels
    document.getElementById('winMessage').textContent = ''; // Clear win message
    document.getElementById('winMessage').classList.remove('active'); // Hide win message

    // Update player turn
    updatePlayerTurn();

    // Refocus the input field for smooth gameplay
    moveInput.value = '';
    gameNote.value = '';
    gameStateInput.value = '';
    gameTextScheme.value = '';
    updateCounters();
    updatePlayerTurn();
    moveInput.focus();
}

// Event listener for the Clear button
clearBtn.addEventListener('click', () => {
    resetGame();
});

// Function to calculate the player turn based on the number of pieces
function calculatePlayerTurn() {
    const totalPieces = gameState.moveHistory.length;
    gameState.currentTurn = totalPieces % 2 === 0 ? 'red' : 'black';
}

let threatsVisible = false; // State to track if threats are currently displayed
// Call updatePlayerTurn at the start to initialize the player turn indicator
updatePlayerTurn();

// Function to convert the board state to the .lp format
function convertBoardToLPFormat() {
    const rows = [];
    for (let row = 5; row >= 0; row--) { // Start from the topmost row
        const rowData = [];
        for (let col = 0; col < 7; col++) { // Columns 1 to 7
            const player = gameState.board[5 - row][col] || 'empty'; // Get player color or 'empty'
            const cellString = `true(cell(${col + 1}, ${row + 1}, ${player}))`; // Correctly calculate X (col) and Y (row) values
            rowData.push(cellString);
        }
        rows.push(rowData.join(' ')); // Join the 7 items with a space
    }
    return rows.join('\n'); // Join all rows with newline characters
}

// Function to convert the board state to the .lp format
function convertBoardToLSFormat() {
    const rows = [];
    for (let row = 5; row > -1; row--) { // Start from row 5 down to row 0 (which corresponds to logical rows 1 to 6)
        const rowData = [];
        for (let col = 0; col < 7; col++) { // Columns 1 to 7
            const player = gameState.board[5 - row][col] || 'empty'; // Get player color or 'empty'
            const playernr = player === 'empty' ? 0 : (player === 'red' ? 1 : 2);
            const cellString = `cell(${col + 1},${row + 1},${playernr}).`; // Correctly calculate X (col) and Y (row) values
            rowData.push(cellString);
        }
        rows.push(rowData.join(' ')); // Join the 7 items with a space
    }
    return rows.join('\n'); // Join all rows with newline characters
}

// Initialize App
createRowLabels();
createColumnLabels();
createBoardUI();

// Refocus the input field for smooth gameplay
moveInput.value = '';
moveInput.focus();

let moveNumbersVisible = true; // Track if move numbers are visible

// Event listener for the Toggle Move Numbers button
document.getElementById('toggleMoveNumbersBtn').addEventListener('click', () => {
    toggleMoveNumbers();
});

// Function to toggle move number visibility
function toggleMoveNumbers() {
    const moveNumberElements = document.querySelectorAll('.piece span'); // Select all move number spans
    moveNumbersVisible = !moveNumbersVisible; // Toggle visibility state

    if (moveNumbersVisible) {
      moveNumberElements.forEach(el => el.classList.remove('hidden')); // Show move numbers
    } else {
        moveNumberElements.forEach(el => el.classList.add('hidden')); // Hide move numbers
    }
}

function hideMoveNumbers() {
    const moveNumberElements = document.querySelectorAll('.piece span'); // Select all move number spans
    moveNumberElements.forEach(el => el.classList.add('hidden')); // Hide move numbers
    moveNumbersVisible = false; // Update visibility state
}

// Save the note whenever the user changes it
document.getElementById('gameNote').addEventListener('input', (event) => {
    gameState.note = event.target.value; // Update the note in gameState
});

// Event listeners for the two new buttons
document.getElementById('showThreatsWhiteBtn').addEventListener('click', () => {
    showThreatsForPlayer('red');
});

document.getElementById('showThreatsBlackBtn').addEventListener('click', () => {
    showThreatsForPlayer('black');
});

// Function to show threats for a specific player
function showThreatsForPlayer(player) {
    const threatCells = detectThreatsForPlayer(player);
    highlightThreats(threatCells, player);
}

// Function to detect threats for a specific player
function detectThreatsForPlayer(player) {
    const threats = [];
    for (let row = 0; row < 6; row++) {
        for (let col = 0; col < 7; col++) {
            if (gameState.board[row][col] === null) { // Check only empty cells
                if (isThreat(row, col, player)) {
                    threats.push({ row, col });
                }
            }
        }
    }
    return threats;
}

// Function to check if placing a piece at (row, col) creates a winning move for the player
function isThreat(row, col, color) {
    const directions = [
        { row: 0, col: 1 },  // Horizontal
        { row: 1, col: 0 },  // Vertical
        { row: 1, col: 1 },  // Diagonal down-right
        { row: 1, col: -1 }  // Diagonal down-left
    ];

    // Temporarily "place" the piece
    gameState.board[row][col] = color;

    let isThreat = false;
    for (const { row: dr, col: dc } of directions) {
        let count = 1;
        for (let i = 1; i < 4; i++) {
            const r = row + dr * i;
            const c = col + dc * i;
            if (r < 0 || r >= 6 || c < 0 || c >= 7) break; // Out of bounds
            if (gameState.board[r][c] === color) {
                count++;
            } else {
                break;
            }
        }
        for (let i = 1; i < 4; i++) {
            const r = row - dr * i;
            const c = col - dc * i;
            if (r < 0 || r >= 6 || c < 0 || c >= 7) break; // Out of bounds
            if (gameState.board[r][c] === color) {
                count++;
            } else {
                break;
            }
        }
        if (count >= 4) {
            isThreat = true;
            break;
        }
    }

    // "Remove" the temporarily placed piece
    gameState.board[row][col] = null;

    return isThreat;
}

// Highlight threat cells on the board for a specific player
function highlightThreats(threatCells, player) {
    clearThreats(); // Remove any previous threat highlights

    threatCells.forEach(({ row, col }) => {
        const cell = boardElement.querySelector(`[data-row="${row}"][data-column="${col}"]`);
        if (cell) {
            cell.classList.add('threat', player); // Add both 'threat' and player-specific class
        }
    });
}

// Clear any highlighted threat cells
function clearThreats() {
    const threatCells = boardElement.querySelectorAll('.threat');
    threatCells.forEach(cell => cell.classList.remove('threat', 'red', 'black'));
}

// Event listener for the Apply Game State button
document.getElementById('applyGameStateBtn').addEventListener('click', () => {
    const gameStateInput = document.getElementById('gameStateInput').value.trim();
    if (!gameStateInput) {
        alert('Please paste a valid game state.');
        return;
    }

    // Parse and apply the game state
    try {
        applyGameStateFromInput(gameStateInput);
        updateBoardUI();
        calculatePlayerTurn(); // Recalculate the current turn based on the filled board
        updatePlayerTurn(); // Update the turn indicator
                hideMoveNumbers(); // Hide move numbers after applying the game state
    } catch (error) {
        alert('Invalid game state format. Please check your input.');
    }
});

function applyGameStateFromInput(input) {
    // Reset the board
    gameState.board = Array.from({ length: 6 }, () => Array(7).fill(null));
    gameState.moveHistory = [];

    // Regex to match the pattern cell(X,Y,P)
    const cellRegex = /(?:cell|next|)\((\d),(\d),(\d)\)/g;
    let match;

    while ((match = cellRegex.exec(input)) !== null) {
        const col = parseInt(match[1], 10) - 1; // Convert to 0-based index for column
        const row = 6 - parseInt(match[2], 10); // Convert to 0-based index for row (invert Y-axis)
        const player = parseInt(match[3], 10);

        let color;
        if (player === 1) {
            color = 'red';
        } else if (player === 2) {
            color = 'black';
        }

        // Place the piece directly in the given (row, col)
        if (color) {
            gameState.board[row][col] = color;
            gameState.moveHistory.push({ row, column: col, color }); // Add to move history
        }
    }

    // Update the board UI based on the new state
    updateBoardUI();
}


// Function to generate the text-based scheme of the game state
function generateTextScheme() {
    const rows = [];
    for (let row = 0; row < 6; row++) { // Start from the bottom row (row 0) and move up
        const rowData = [];
        for (let col = 0; col < 7; col++) { // Columns 1 to 7
            const cell = gameState.board[row][col];
            if (cell === 'red') {
                rowData.push('1'); // red = 1
            } else if (cell === 'black') {
                rowData.push('2'); // Black = 2
            } else {
                rowData.push('.'); // Empty = .
            }
        }
        rows.push(rowData.join(' ')); // Join each row with spaces
    }
    return rows.join('\n'); // Join all rows with newline characters
}

// Update the text-based scheme after pasting the game state
function updateTextScheme() {
    const textScheme = generateTextScheme();
    document.getElementById('gameTextScheme').value = textScheme;
}

// Update updateBoardUI to include updating the text scheme
function updateBoardUI() {
    createBoardUI(); // Recreate the visual board
    gameState.moveHistory.forEach((move, index) => {
        updateUI(move.row, move.column, move.color, index + 1); // Update each piece visually
    });
    updateTextScheme();
    updateCounters();
    updatePlayerTurn();
}

// Function to simulate a game 
document.getElementById('simulateBtn').addEventListener('click', () => {
      // Read the selected strategy names
  const whiteName = document.getElementById('strategyRed').value;
  const blackName = document.getElementById('strategyBlack').value;
  // Look up the actual functions
  const strategyWhite = strategies[whiteName];
  const strategyBlack = strategies[blackName];
    // Sanity check
  if (!strategyWhite || !strategyBlack) {
    console.error('One of the selected strategies is not defined:', whiteName, blackName);
    return;
  }
    simulateGame(strategyWhite,strategyBlack);
});

async function simulateGame(strategyWhite, strategyBlack) {
    resetGame(); 
    let currentPlayer = 'red'; 
    while (!gameState.gameOver) {
        const legalColumns = getLegalColumns();
        if (legalColumns.length === 0) {
           // board is full, stop the simulation with no winner
           break;
        }
        const strategy = currentPlayer === 'red' ? strategyWhite : strategyBlack;
        const chosenColumn = doMove(strategy);
        placePieceInColumn(chosenColumn);
        currentPlayer = (currentPlayer === 'red' ? 'black' : 'red');
        await delay(100);
    }
}

// Function to choose a column based on the strategy
function doMove(strategy) {
    const legalColumns = getLegalColumns(); // Get a list of columns that are not full
    if (legalColumns.length === 0) throw new Error('No legal moves available.');
    return strategy(legalColumns); // Pass the legal columns to the strategy function
}

// Function to introduce a delay (Step 8)
function delay(ms) {
    return new Promise(resolve => setTimeout(resolve, ms));
}

// Utility function to get legal columns
function getLegalColumns() {
    const legalColumns = [];
    for (let col = 0; col < 7; col++) {
        if (findLowestEmptyCell(col)) {
            legalColumns.push(col);
        }
    }
    return legalColumns;
}

// Example strategy: Prefer middle columns
function preferMiddleStrategy(legalColumns) {
    const middleColumns = [3, 2, 4, 1, 5, 0, 6]; // Column preference order (center to edges)
    for (const col of middleColumns) {
        if (legalColumns.includes(col)) {
            return col;
        }
    }
    return legalColumns[0]; // Default to the first legal column
}

// Example strategy: Mimic the opponent's last move
function mimicOpponentStrategy(legalColumns) {
    if (gameState.moveHistory.length > 0) {
        const lastMove = gameState.moveHistory[gameState.moveHistory.length - 1];
        if (legalColumns.includes(lastMove.column)) {
            return lastMove.column;
        }
    }
    // No winning or blocking moves, random
    const randomIndex = Math.floor(Math.random() * legalColumns.length);
    return legalColumns[randomIndex];
}

// Strategy: Choose a random column
function randomStrategy(legalColumns) {
    const randomIndex = Math.floor(Math.random() * legalColumns.length);
    return legalColumns[randomIndex];
}

// Strategy: Win if possible, block opponent's threat if needed, prefer middle columns otherwise
function threatBasedStrategy(legalColumns) {
    const currentPlayer = gameState.currentTurn; // 'red' or 'black'
    const opponent = currentPlayer === 'red' ? 'black' : 'red';

    // Step 1: Check for winning threats for the current player
    for (const col of legalColumns) {
        const lowestCell = findLowestEmptyCell(col);
        if (lowestCell && isThreat(lowestCell.row, col, currentPlayer)) {
            return col; // Play in the winning column
        }
    }

    // Step 2: Check for threats by the opponent and block them
    for (const col of legalColumns) {
        const lowestCell = findLowestEmptyCell(col);
        if (lowestCell && isThreat(lowestCell.row, col, opponent)) {
            return col; // Block the opponent's threat
        }
    }

    // Step 3: No winning or blocking moves, prefer middle columns
    const middleColumns = [3, 2, 4, 1, 5, 0, 6]; // Preference order
    for (const col of middleColumns) {
        if (legalColumns.includes(col)) {
            return col; // Choose the nearest available column to the middle
        }
    }

    // Default to the first legal column (this shouldn't happen)
    return legalColumns[0];
}

// Strategy: Win if possible, block opponent's threat if needed, prefer middle columns otherwise
function threatOrRandomStrategy(legalColumns) {
    const currentPlayer = gameState.currentTurn; // red' or 'black'
    const opponent = currentPlayer === 'red' ? 'black' : 'red';

    // Step 1: Check for winning threats for the current player
    for (const col of legalColumns) {
        const lowestCell = findLowestEmptyCell(col);
        if (lowestCell && isThreat(lowestCell.row, col, currentPlayer)) {
            return col; // Play in the winning column
        }
    }

    // Step 2: Check for threats by the opponent and block them
    for (const col of legalColumns) {
        const lowestCell = findLowestEmptyCell(col);
        if (lowestCell && isThreat(lowestCell.row, col, opponent)) {
            return col; // Block the opponent's threat
        }
    }

    // Step 3: No winning or blocking moves, random
    const randomIndex = Math.floor(Math.random() * legalColumns.length);
    return legalColumns[randomIndex];
    
}

// Function to save the current game state in cumulative format
function appendCurrentGameState() {
    const currentGameState = convertBoardToLSFormat(); // Convert current game state to .lp format
    const preAmble='#pos({},{hor(1),hor(2),ver(1),ver(2),dia1(1),dia1(2),dia2(1),dia2(2)},{\n'
    const postAmble='\n}).'
    cumulativeGameStates += preAmble + currentGameState + postAmble + '\n\n'; // Append to cumulative states with a blank line separator
}

// Function to save the cumulative game states to a file
function saveCumulativeGameStates() {
    const fileNameInput = document.getElementById('fileNameInput');
    let fileName = fileNameInput && fileNameInput.value.trim() ? fileNameInput.value.trim() : 'cumulative_game_states';
    if (!fileName.endsWith('.lp')) fileName += '.lp';

    // Download the cumulative game states as a single file
    downloadFile(cumulativeGameStates.trim(), fileName, 'text/plain');
}


// Add Export Logic Button
document.getElementById('exportLogicBtn').addEventListener('click', () => {
    const output = generateLogicExport();
    const fileName = 'game_state_logic.lp';
    downloadFile(output, fileName, 'text/plain');
});

function generateLogicExport() {
    const winningLines = detectWinningLines(); // Get all valid lines of four
    let formula1 = '';
    let formula2 = '';
    let formula3 = '';

    // Formula 1: Collect all winning lines
    const formula1Terms = new Set();
    const includedPatterns = new Set(); // Track patterns that should be included in Formula 2

    if (winningLines.length > 0) {
        winningLines.forEach(({ type, startX, startY, player }) => {
            const term = `${type}(${startX},${startY},${player})`;
            formula1Terms.add(term);
            includedPatterns.add(type); // Store the pattern type (horz, vert, dia1, dia2)
        });

        formula1 = [...formula1Terms].join(', '); // Convert set to a comma-separated string
    }

    // Formula 2: 4 groups (horz, vert, dia1, dia2), 3 blocks (P=0, P=1, P=2) each
    const patterns = ['horz', 'vert', 'dia1', 'dia2']; // The 4 pattern types
    const maxX = 7; // Max columns
    const maxY = 6; // Max rows
    const maxP = 2; // Players 0, 1, 2
    const blocks = [];

    includedPatterns.forEach((pattern) => { // Only process patterns that exist in Formula 1
        for (let p = 0; p <= maxP; p++) {
            const rows = [];
            for (let y = maxY; y >= 1; y--) { // Start from Y=6 (top row) to Y=1 (bottom row)
                const row = [];
                for (let x = 1; x <= maxX; x++) { // X=1 to X=7
                    const term = `${pattern}(${x},${y},${p})`;
                    // If term exists in Formula 1, replace with 12 spaces
                    row.push(formula1Terms.has(term) ? ' '.repeat(12) : term);
                }
                rows.push(row.join(', ')); // Join columns with a comma
            }
            blocks.push(rows.join(', \n')); // Join rows with a newline
        }

    });    

    formula2_bruto = blocks.join(', \n\n'); // Join blocks with newlines
    formula2 = formula2_bruto.replace(/ {12},/g, ' '.repeat(12));

    // Formula 3: Current board state in board order
    const currentBoard = [];
    for (let row = 5; row >= 0; row--) { // Bottom (Y=1) to top (Y=6)
        const rowData = [];
        for (let col = 0; col < 7; col++) {
            const player = gameState.board[row][col] === 'red' ? 1 : gameState.board[row][col] === 'black' ? 2 : 0;
            const y = 6 - row; // Map row index to Y-values (6 for top, 1 for bottom)
            rowData.push(`cell(${col + 1},${y},${player})`);
        }
        currentBoard.push(rowData.join('. ') + '.'); // Push rows in correct order
    }
    formula3 = currentBoard.reverse().join('\n'); // Reverse rows so output starts with the topmost row (Y=6)

    // Combine formulas into the output format
    return `#pos({${formula1}},{\n${formula2}\n},{\n${formula3}\n}).\n` +
       '\n' + // Adds a blank line before the scheme
       generateTextScheme().split("\n").map(line => "% " + line).join("\n");

}

function detectWinningLines() {
    const directions = [
        { type: 'horz', row: 0, col: 1 },  // Horizontal
        { type: 'vert', row: 1, col: 0 },  // Vertical
        { type: 'dia1', row: -1, col: 1 },  // Diagonal SW-NE
        { type: 'dia2', row: 1, col: 1 }    // Diagonal NW-SE 
    ];

    const winningLines = []; // Store all winning lines

    for (let row = 0; row < 6; row++) {
        for (let col = 0; col < 7; col++) {
            const color = gameState.board[row][col];
            if (!color) continue; // Skip empty cells

            const player = color === 'red' ? 1 : 2;

            for (const { type, row: dr, col: dc } of directions) {
                let count = 1;
                let cells = [{ x: col + 1, y: 6 - row }]; // Track cells in the winning line

                for (let i = 1; i < 4; i++) {
                    const r = row + dr * i;
                    const c = col + dc * i;
                    if (r < 0 || r >= 6 || c < 0 || c >= 7) break; // Out of bounds
                    if (gameState.board[r][c] === color) {
                        count++;
                        cells.push({ x: c + 1, y: 6 - r });
                    } else {
                        break;
                    }
                }

                if (count === 4) {
                    // Correctly determine the start position for diagonal lines
                    let startX = cells[0].x;
                    let startY = cells[0].y;

                    if (type === 'vert') {
                        // Vertical lines should start at the lowest Y-value
                        let minYCell = cells.reduce((min, curr) =>
                            curr.y < min.y ? curr : min, cells[0]);
                        startX = minYCell.x;
                        startY = minYCell.y;
                    } else if (type === 'dia1') {
                        // SW-NE diagonal: Take the lowest X and Y as the starting point
                        const minCell = cells.reduce((min, curr) =>
                            (curr.x < min.x || curr.y < min.y) ? curr : min, cells[0]);
                        startX = minCell.x;
                        startY = minCell.y;
                    } else if (type === 'dia2') {
                        // NW-SE diagonal: Take the lowest X but the highest Y as the starting point
                        const minCell = cells.reduce((min, curr) =>
                            (curr.x < min.x || curr.y > min.y) ? curr : min, cells[0]);
                        startX = minCell.x;
                        startY = minCell.y;
                    }

                    // Check if this line is already recorded
                    const alreadyExists = winningLines.some(
                        (line) =>
                            line.type === type &&
                            line.startX === startX &&
                            line.startY === startY &&
                            line.player === player
                    );

                    if (!alreadyExists) {
                        winningLines.push({
                            type,
                            startX,
                            startY,
                            player,
                            cells, // Include all cells in the line for further processing if needed
                        });
                    }
                }
            }
        }
    }

    return winningLines; // Return all winning lines
}

document.getElementById('runBatch').addEventListener('click', runBatch);

async function runBatch() {
  const input = document.getElementById('batchResults');
  const desired = Math.max(1, parseInt(input.value, 10) || 10);

  let count = 0;
  const btn = document.getElementById('runBatch');
  btn.disabled = true;
  btn.textContent = `Running… (0/${desired})`;

  while (count < desired) {
    // 1) start fresh
    resetGame();

    // 2) actually wait for the simulation to run to completion
    await simulateGame(threatOrRandomStrategy, threatBasedStrategy);

    // 3) only export *if* there’s a winner
    const winner = detectWinner();
    if (winner) {
      const output = generateLogicExport();
      // 4) download each winner into its own file
      const fileName = `batch_result_${count+1}.lp`;
      downloadFile(output, fileName, 'text/plain');

      count++;
      btn.textContent = `Running… (${count}/${desired})`;
    }
    // otherwise: no winner, loop again without bumping count
  }

  btn.textContent = `Done! Generated ${count} results`;
  btn.disabled = false;
}

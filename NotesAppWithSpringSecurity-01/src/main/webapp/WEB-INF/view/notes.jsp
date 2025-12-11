<!DOCTYPE html>
<%@ page contentType="text/html;charset=UTF-8" %>
<html>
<head>
<title>Your Notes</title>

<style>
    body {
        margin: 0;
        padding: 0;
        font-family: "Segoe UI", Arial, sans-serif;
        background: linear-gradient(135deg, #6a11cb, #2575fc);
        min-height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
    }

    .container {
        background: rgba(255, 255, 255, 0.15);
        padding: 30px;
        border-radius: 12px;
        width: 80%;
        max-width: 900px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        backdrop-filter: blur(10px);
    }

    h2 {
        text-align: center;
        margin-bottom: 25px;
        font-size: 28px;
    }

    .add-btn {
        background: #6a11cb;
        color: white;
        padding: 10px 16px;
        border-radius: 6px;
        text-decoration: none;
        font-weight: bold;
        transition: 0.3s;
    }

    .add-btn:hover {
        background: #4c0f9f;
    }

    table {
        width: 100%;
        border-collapse: collapse;
        margin-top: 20px;
        background: rgba(255, 255, 255, 0.3);
        color: black;
        border-radius: 10px;
        overflow: hidden;
    }

    th, td {
        padding: 12px;
        text-align: left;
        background: rgba(255, 255, 255, 0.15);
        color: white;
    }

    th {
        background: rgba(0, 0, 0, 0.3);
        font-size: 16px;
    }

    a.action-link {
        color: #ffeb3b;
        text-decoration: none;
        font-weight: bold;
        cursor: pointer;
    }

    a.action-link:hover {
        color: #fff;
    }

    /* ====== Delete Confirmation Popup ====== */
    #confirmPopup {
        position: fixed;
        top: 0; 
        left: 0;
        width: 100%;
        height: 100%;
        background: rgba(0,0,0,0.6);
        display: none;
        justify-content: center;
        align-items: center;
    }

    .popup-box {
        background: white;
        color: black;
        padding: 25px;
        border-radius: 10px;
        width: 350px;
        text-align: center;
        animation: pop 0.25s ease-out;
    }

    @keyframes pop {
        0% { transform: scale(0.7); opacity: 0; }
        100% { transform: scale(1); opacity: 1; }
    }

    .popup-btn {
        padding: 10px 18px;
        border: none;
        border-radius: 6px;
        margin: 10px;
        cursor: pointer;
        font-weight: bold;
    }

    .cancel-btn {
        background: #999;
        color: white;
    }

    .delete-btn {
        background: #e53935;
        color: white;
    }

    .delete-btn:hover { background: #b71c1c; }
    .cancel-btn:hover { background: #777; }

    /* ===== SUCCESS & ERROR POPUPS ===== */
    #messagePopup {
        position: fixed;
        bottom: 30px;
        right: 30px;
        background: white;
        color: black;
        padding: 18px 25px;
        border-radius: 10px;
        display: none;
        min-width: 200px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.25);
        animation: fadeIn 0.3s ease-out;
    }

    #messagePopup.success { border-left: 6px solid #4caf50; }
    #messagePopup.error   { border-left: 6px solid #e53935; }

    @keyframes fadeIn {
        0% { opacity: 0; transform: translateY(20px); }
        100% { opacity: 1; transform: translateY(0); }
    }
</style>


<script>
let deleteId = null;

// Load Notes
async function loadNotes() {
    const token = localStorage.getItem("token");

    const res = await fetch("/api/notes", {
        headers: { "Authorization": "Bearer " + token }
    });

    if (res.status === 403) {
        showPopup("Not authorized. Please login.", "error");
        window.location.href = "/login";
        return;
    }

    const notes = await res.json();
    let rows = "";

    notes.forEach(n => {
        rows += '<tr>';
        rows += '<td>' + n.title + '</td>';
        rows += '<td>' + n.content + '</td>';
        rows += '<td>';
        rows += '<a class="action-link" href="/notes/edit/' + n.id + '">Edit</a> | ';
        rows += '<a class="action-link delete-btn-link" onclick="confirmDelete(' + n.id + ')">Delete</a> | ';
        rows += '<a class="action-link" href="/notes/ai/' + n.id + '">AI Improve</a>';
        rows += '</td>';
        rows += '</tr>';
    });

    document.getElementById("notesTableBody").innerHTML = rows;
}

// Show Delete Popup
function confirmDelete(id) {
    deleteId = id;
    document.getElementById("confirmPopup").style.display = "flex";
}

// Close Delete Popup
function closePopup() {
    deleteId = null;
    document.getElementById("confirmPopup").style.display = "none";
}

// SHOW SUCCESS / ERROR POPUP
function showPopup(message, type) {
    const box = document.getElementById("messagePopup");
    box.innerText = message;
    box.className = type;
    box.style.display = "block";

    setTimeout(() => box.style.display = "none", 2000);
}

// Call API → delete note
async function deleteNote() {
    const token = localStorage.getItem("token");

    const res = await fetch("/api/notes/" + deleteId, {
        method: "DELETE",
        headers: { "Authorization": "Bearer " + token }
    });

    closePopup();

    if (res.status === 204) {
        showPopup("Note deleted!", "success");
        setTimeout(() => window.location.reload(), 1200);
    } else {
        showPopup("Failed to delete note.", "error");
    }
}

window.onload = loadNotes;
</script>

</head>
<body>

<div class="container">
    <h2>Your Notes</h2>

    <a href="/notes/add-note" class="add-btn">+ Add New Note</a>

    <table>
        <thead>
            <tr>
                <th>Title</th>
                <th>Description</th>
                <th>Actions</th>
            </tr>
        </thead>

        <tbody id="notesTableBody">
            <tr><td colspan="3" style="text-align:center;">Loading notes...</td></tr>
        </tbody>
    </table>
</div>

<!-- ===== Delete Confirmation Popup ===== -->
<div id="confirmPopup">
    <div class="popup-box">
        <h3>Delete Note?</h3>
        <p>Are you sure you want to delete this note? This action cannot be undone.</p>

        <button class="popup-btn cancel-btn" onclick="closePopup()">Cancel</button>
        <button class="popup-btn delete-btn" onclick="deleteNote()">Delete Note</button>
    </div>
</div>

<!-- SUCCESS / ERROR POPUP -->
<div id="messagePopup"></div>

</body>
</html>

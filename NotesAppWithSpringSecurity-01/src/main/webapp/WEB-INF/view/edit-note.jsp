<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Edit Note</title>

<style>
    /* ------------ Existing Beautiful UI (Unchanged) ------------ */
    body {
        margin: 0;
        padding: 0;
        font-family: "Segoe UI", Arial, sans-serif;
        background: linear-gradient(135deg, #6a11cb, #2575fc);
        height: 100vh;
        display: flex;
        align-items: center;
        justify-content: center;
        color: white;
    }

    .container {
        background: rgba(255, 255, 255, 0.13);
        padding: 40px;
        border-radius: 12px;
        width: 350px;
        box-shadow: 0 8px 30px rgba(0,0,0,0.3);
        backdrop-filter: blur(10px);
        text-align: left;
    }

    h2 {
        margin-bottom: 25px;
        font-size: 26px;
        text-align: center;
    }

    form { display: flex; flex-direction: column; }

    label { font-weight: bold; margin-top: 15px; margin-bottom: 5px; }

    input[type="text"], textarea {
        width: 100%;
        padding: 10px;
        border-radius: 6px;
        border: none;
        outline: none;
        color: #333;
        background-color: rgba(255, 255, 255, 0.9);
        transition: .3s;
    }

    textarea { resize: vertical; }

    input[type="text"]:focus, textarea:focus {
        border: 2px solid #2575fc;
    }

    button {
        width: 100%;
        padding: 12px;
        margin-top: 30px;
        background: #2575fc;
        color: white;
        border: none;
        font-size: 16px;
        border-radius: 6px;
        cursor: pointer;
        transition: .3s;
        box-shadow: 0 4px 10px rgba(0, 0, 0, 0.2);
    }

    button:hover {
        background: #1254c4;
        box-shadow: 0 6px 15px rgba(0, 0, 0, 0.3);
    }


    /* ------------ NEW TOAST CSS ------------ */
    #toast {
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 15px 22px;
        border-radius: 8px;
        font-size: 15px;
        font-weight: bold;
        color: white;
        display: none;
        opacity: 0;
        animation: fadeInOut 3s ease forwards;
        z-index: 9999;
    }

    #toast.success { background: #2ecc71; }
    #toast.error { background: #e74c3c; }

    @keyframes fadeInOut {
        0% { opacity: 0; transform: translateY(-20px); }
        10% { opacity: 1; transform: translateY(0); }
        90% { opacity: 1; }
        100% { opacity: 0; transform: translateY(-20px); }
    }
</style>

</head>
<body>

<div class="container">

<h2>Edit Note</h2>

<form onsubmit="updateNote(event)">
    <input type="hidden" id="noteId" value="${note.id}" />

    <label for="title">Title:</label> 
    <input type="text" id="title" name="title" value="${note.title}" required>

    <label for="description">Description:</label>
    <textarea id="description" name="description" rows="5" cols="40">${note.content}</textarea>

    <button type="submit">Update</button>
</form>

</div>

<!-- TOAST POPUP -->
<div id="toast"></div>

<script>
/* -------- TOAST FUNCTION -------- */
function showToast(msg, type) {
    const toast = document.getElementById("toast");
    toast.innerHTML = msg;
    toast.className = type;
    toast.style.display = "block";

    setTimeout(() => { toast.style.display = "none"; }, 3000);
}

/* -------- UPDATE NOTE FUNCTION (Original Logic Preserved) -------- */
async function updateNote(event) {
    event.preventDefault();

    const id = document.getElementById("noteId").value;
    const token = localStorage.getItem("token");

    const title = document.getElementById("title").value;
    const content = document.getElementById("description").value;

    const res = await fetch("/api/notes/" + id, {
        method: "PUT",
        headers: {
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"
        },
        body: JSON.stringify({ title, content })
    });

    if (res.status === 200) {
        showToast("✔ Updated Successfully!", "success");
        setTimeout(() => { window.location.href = "/notes"; }, 1500);
    } else {
        showToast("✘ Failed to update note!", "error");
    }
}
</script>

</body>
</html>

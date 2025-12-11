<%@ page contentType="text/html;charset=UTF-8" %>
<!DOCTYPE html>
<html>
<head>
<title>Add Note - Notes AI</title>

<style>
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
        width: 380px;
        box-shadow: 0 8px 20px rgba(0,0,0,0.2);
        backdrop-filter: blur(10px);
        text-align: center;
    }

    h2 {
        margin-bottom: 25px;
        font-size: 26px;
    }

    input, textarea {
        width: 100%;
        padding: 10px;
        border-radius: 6px;
        border: none;
        margin-bottom: 15px;
        font-size: 15px;
    }

    textarea {
        resize: none;
    }

    button {
        width: 100%;
        padding: 12px;
        background: #6a11cb;
        border: none;
        border-radius: 6px;
        color: white;
        font-weight: bold;
        font-size: 16px;
        cursor: pointer;
        transition: 0.3s;
    }

    button:hover {
        background: #4c0f9f;
    }

    a {
        color: #fff;
        display: block;
        margin-top: 15px;
        text-decoration: underline;
    }

    /* ================== TOAST POPUP CSS ================== */
    #toast {
        position: fixed;
        top: 20px;
        right: 20px;
        padding: 14px 22px;
        border-radius: 6px;
        color: white;
        font-weight: bold;
        display: none;
        min-width: 200px;
        box-shadow: 0 4px 12px rgba(0,0,0,0.3);
        z-index: 9999;
        animation: fadeInOut 3s ease;
    }

    @keyframes fadeInOut {
        0% { opacity: 0; transform: translateY(-20px); }
        10% { opacity: 1; transform: translateY(0); }
        90% { opacity: 1; transform: translateY(0); }
        100% { opacity: 0; transform: translateY(-20px); }
    }
</style>

<script>

function showToast(message, type) {
    const toast = document.getElementById("toast");
    toast.innerText = message;

    if (type === "success") {
        toast.style.background = "#2ecc71";   // green
    } else {
        toast.style.background = "#e74c3c";   // red
    }

    toast.style.display = "block";

    setTimeout(() => {
        toast.style.display = "none";
    }, 3000);
}

async function saveNote() {
    const token = localStorage.getItem("token");
    const dto = {
        title: document.getElementById("title").value,
        content: document.getElementById("description").value
    };

    const res = await fetch("/api/notes", {
        method: "POST",
        headers: {
            "Authorization": "Bearer " + token,
            "Content-Type": "application/json"
        },
        body: JSON.stringify(dto)
    });

    if (res.status === 200) {
        showToast("Note Saved Successfully!", "success");
        setTimeout(() => window.location.href = "/notes", 1200);
    } else {
        showToast("Failed to Save Note!", "error");
    }
}
</script>

</head>

<body>

<!-- Toast Box -->
<div id="toast"></div>

<div class="container">
    <h2>Add New Note</h2>

    <form id="noteForm" onsubmit="event.preventDefault(); saveNote();">
        <input type="text" id="title" placeholder="Enter title" required>
        <textarea id="description" rows="5" placeholder="Enter description" required></textarea>
        <button type="submit">Save Note</button>
    </form>

    <a href="/notes">⬅ Back to Notes</a>
</div>

</body>
</html>

document.getElementById('loginForm').addEventListener('submit', function(event) {
    event.preventDefault();

    const username = document.getElementById('username').value;
    const password = document.getElementById('password').value;

    const mockUsername = 'admin';
    const mockPassword = 'password';

    if (username === mockUsername && password === mockPassword) {

        window.location.href = 'admin_dashboard.html';
    } else {

        document.getElementById('error').innerText = 'Invalid username or password';
    }
});


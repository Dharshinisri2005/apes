import socket

server_socket = socket.socket(socket.AF_INET, socket.SOCK_STREAM)
server_socket.bind(("0.0.0.0", 12345))
server_socket.listen(5)

print("Server is listening on port 12345...")

client_socket, client_address = server_socket.accept()
print(f"Connection established with {client_address}")

message = client_socket.recv(1024).decode()
print(f"Client: {message}")

client_socket.send("Hello, Client!".encode())

client_socket.close()
server_socket.close()

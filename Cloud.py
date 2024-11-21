import socket
import pickle

# Cloud server setup
HOST = "0.0.0.0"  # Listen on all interfaces
PORT = 5000

# Start server to receive process data
with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server_socket:
    server_socket.bind((HOST, PORT))
    server_socket.listen(5)
    print("Cloud server is listening...")

    while True:
        conn, addr = server_socket.accept()
        print(f"Connection established with {addr}")
        with conn:
            data = conn.recv(4096)
            if data:
                # Deserialize the received data
                processes_info = pickle.loads(data)
                print(f"Received {len(processes_info)} processes:")
                for proc in processes_info[:5]:  # Print first 5 processes
                    print(f"PID: {proc['pid']}, Name: {proc['name']}, CPU%: {proc['cpu_percent']}, Memory%: {proc['memory_percent']}")

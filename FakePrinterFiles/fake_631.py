import socket

def start_listener(host='0.0.0.0', port=631):
    """Starts a basic TCP server that listens on port 9100 perpetually."""
    with socket.socket(socket.AF_INET, socket.SOCK_STREAM) as server_socket:
        server_socket.setsockopt(socket.SOL_SOCKET, socket.SO_REUSEADDR, 1)
        server_socket.bind((host, port))
        server_socket.listen()
        print(f"Listening on {host}:{port}...")
        
        while True:
            conn, addr = server_socket.accept()
            print(f"Connection received from {addr}")
            # Keep the connection open until the client disconnects
            try:
                while True:
                    data = conn.recv(1024)
                    if not data:
                        break
            except ConnectionResetError:
                pass  # Handle unexpected client disconnects
            finally:
                conn.close()
                print(f"Connection closed from {addr}")

if __name__ == "__main__":
    start_listener()

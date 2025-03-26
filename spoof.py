from scapy.all import IP, ICMP, send

spoofed_ip = "192.168.1.100"
target_ip = "192.168.1.200"

ip_layer = IP(src=spoofed_ip, dst=target_ip)
icmp_layer = ICMP()

send(ip_layer / icmp_layer)

print(f"Sent spoofed ICMP packet from {spoofed_ip} to {target_ip}")

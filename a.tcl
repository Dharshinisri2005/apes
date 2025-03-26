set ns [new Simulator]

# Enable tracing
set tracefile [open out.tr w]
$ns trace-all $tracefile

# Enable NAM tracing
set namfile [open out.nam w]
$ns namtrace-all $namfile

# Create nodes (1 central + 4 leaf nodes)
set n0 [$ns node]  ;# Central Node (Hub)
set n1 [$ns node]
set n2 [$ns node]
set n3 [$ns node]
set n4 [$ns node]

# Create links between the central node and leaf nodes
$ns duplex-link $n0 $n1 1Mb 10ms DropTail
$ns duplex-link $n0 $n2 1Mb 10ms DropTail
$ns duplex-link $n0 $n3 1Mb 10ms DropTail
$ns duplex-link $n0 $n4 1Mb 10ms DropTail

# Setup TCP connections from central node to each leaf node
set tcp1 [new Agent/TCP]
$ns attach-agent $n0 $tcp1
set sink1 [new Agent/TCPSink]
$ns attach-agent $n1 $sink1
$ns connect $tcp1 $sink1

set tcp2 [new Agent/TCP]
$ns attach-agent $n0 $tcp2
set sink2 [new Agent/TCPSink]
$ns attach-agent $n2 $sink2
$ns connect $tcp2 $sink2

set tcp3 [new Agent/TCP]
$ns attach-agent $n0 $tcp3
set sink3 [new Agent/TCPSink]
$ns attach-agent $n3 $sink3
$ns connect $tcp3 $sink3

set tcp4 [new Agent/TCP]
$ns attach-agent $n0 $tcp4
set sink4 [new Agent/TCPSink]
$ns attach-agent $n4 $sink4
$ns connect $tcp4 $sink4

# Attach FTP applications to each TCP agent
set ftp1 [new Application/FTP]
$ftp1 attach-agent $tcp1
$ftp1 set type_ FTP
$ns at 0.5 "$ftp1 start"

set ftp2 [new Application/FTP]
$ftp2 attach-agent $tcp2
$ftp2 set type_ FTP
$ns at 0.5 "$ftp2 start"

set ftp3 [new Application/FTP]
$ftp3 attach-agent $tcp3
$ftp3 set type_ FTP
$ns at 0.5 "$ftp3 start"

set ftp4 [new Application/FTP]
$ftp4 attach-agent $tcp4
$ftp4 set type_ FTP
$ns at 0.5 "$ftp4 start"

# Define finish procedure
proc finish {} {
    global ns tracefile namfile
    $ns flush-trace
    close $tracefile
    close $namfile
    puts "Simulation completed. Running NAM..."

    # Check if NAM is installed before executing
    if {[catch {exec nam out.nam &} err]} {
        puts "NAM not found. Please install it or check your path."
    }

    exit 0
}

# Schedule simulation to end at 5 seconds
$ns at 5.0 "finish"

# Run the simulation
$ns run

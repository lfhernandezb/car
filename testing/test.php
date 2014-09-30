 <?php
    for ($j = 1; $j <= 10; $j++) {
		for ($i = 1; $i <= 10; ++$i) {
			$pid = pcntl_fork();

			if (!$pid) {
				sleep(1);
				print "Iteration $j child $i\n";
				
				/* Get the port for the WWW service. */

				//$service_port = getservbyname('www', 'tcp');

				/*if you already know the destination port, you don't need getservbyname, you can do this: $service_port = port;

				Example: $service_port="10000″;*/
				
				$service_port="8080";

				/* Get the IP address for the target host. */

				$address = gethostbyname('www.manadachile.cl');

				/*if you already know the ip of the destination, you don't need gethostbyname, you can do this: $address = ip address;

				Example: $address = 192.168.10.1 */
				
				//$address = '192.168.10.1';

				/* Create a TCP/IP socket. */

				$socket = socket_create(AF_INET, SOCK_STREAM, SOL_TCP);

				if ($socket === false) {

					echo "socket_create() failed: reason: " . socket_strerror(socket_last_error()) . "\n";
					exit(-1);

				} else {

					//echo "OK.\n";

				}

				//echo "Attempting to connect to '$address' on port '$service_port'…";

				$result = socket_connect($socket, $address, $service_port);

				if ($result === false) {

					echo "socket_connect() failed.\nReason: ($result) " . socket_strerror(socket_last_error($socket)) . "\n";
					exit(-1);

				} else {

					//echo "OK.\n";

				}

				$in = "GET /cl.dsoft.carws/rest/todo/byIdUsuario/1/1900-01-01\r\n";
				
				//echo $in;

				$out = "";

				//echo "Sending message…";

				socket_write($socket, $in, strlen($in));

				//echo "OK.\n";

				//echo "Reading response:\n\n";

				$out = socket_read($socket, 2048);

				//echo $out . "\n";
				echo "RECV $j $i\n";
				
				exit(0);
			}
		}
		
		sleep(2);
	}

    while (pcntl_waitpid(0, $status) != -1) {
        $status = pcntl_wexitstatus($status);
        // echo "Child completed, status $status\n";
    }
?> 

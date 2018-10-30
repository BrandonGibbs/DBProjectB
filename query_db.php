<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<title>Make your query!</title>
	</head>
	<body>
	<?php
	$servername = "localhost";
	$username = $_POST['username'];
	$password = $_POST['password'];
	$dbname = "examplePharmacy";
	$conn = new mysqli($servername, $username, $password, $dbname);

	if ($conn->connect_error){
		echo "Error: " . "something something something";
	} else {
		$_SESSION['username'] = $username;
		$_SESSION['password'] = $password;
		echo "<form action=\'/query_results.php\' method=\'POST\'>
			  Query: <input type=\'text\' name=\'q\'></input><br>
			  <input type=\'submit\'></input>
			  </form>";
		$conn->close();
	}
	?>
	</body>
</html>

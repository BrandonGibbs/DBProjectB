<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="ie=edge">
		<title>Zombie Pharmacy Login</title>
	</head>
	<body>
<?php 
	include "head.php";
	include "navigation.php";
?>
	<h2>Login:</h2>
	<form action='/index.php' method='POST'>
		Username: <input type='text' name='username'></input><br/>
		Password: <input type='password' name='password'></input><br/>
		<input type='submit'></input>
	</form>
</body>
</html>

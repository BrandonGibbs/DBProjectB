<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<link rel="stylesheet" href="all_styles.css">
		<title>Zombie Pharmacy Search</title>
	</head>
	<body>
<?php 
	include "head.php";
	include "navigation.php";
	include "subroutines.php";
?>
	<h2>Find one of our locations near you!</h2>
	<form action='<?php echo validate_input_field($_SERVER["PHP_SELF"]);?>' method='GET'>
	  Country: <input type='text' name='country'></input><br>
	    State: <input type='text' name='state'></input><br>
	  <input type='submit' value="Search"></input>
	</form>
<?php
	// validate input and add country and state attributes to pharmacy 
	conn_exec_query(
		'gen_table_from_select',
		"SELECT * FROM pharmacy;");
?>
	</body>
</html>

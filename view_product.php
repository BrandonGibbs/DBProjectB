<!DOCTYPE html>
<html lang="en">
	<head>
		<meta charset="UTF-8">
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta http-equiv="X-UA-Compatible" content="ie=edge">
		<link rel="stylesheet" href="all_styles.css">
		<title>Zombie Pharmacy: View Product</title>
	</head>
	<body>
<?php 
	include "head.php";
	include "navigation.php";
	include "subroutines.php";

	// expect upc to be the only parameter
	if (!empty($_GET['upc'])){
		$upcStr = validate_input_field($_GET['upc']);
		if (is_numeric($upcStr)){
			$upcInt = (int) $upcStr;
			if ($upcInt >= 0 && $upcInt <= 999999999999){
?>
	<h2>Some buttons for buying if signed in and stuff</h2>
<?php	
			} else {
				echo "<b class=\"error\">Input field out of range: upc</b><br/>";
			}
		} else {
			echo "<b class=\"error\">Input field must be a 12 digit integer</b><br/>";
		}
	}
?>
	</body>
</html>

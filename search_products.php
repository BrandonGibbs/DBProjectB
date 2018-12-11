<!DOCTYPE html>
<html>
	<head>
		<meta charset="utf-8">
		<link rel="stylesheet" href="all_styles.css">
		<title>Product Search</title>
	</head>
	<body>
<?php 
	include "head.php";
	include "navigation.php";
	include "subroutines.php";
?>
	<h2>Product Search</h2>
	<form action='<?php echo validate_input_field($_SERVER["PHP_SELF"]);?>' method='GET'>
	           UPC: <input type='text' name='upc'></input><br>
	  Product Name: <input type='text' name='prod_name'></input><br>
	  <input type='submit' value="Search"></input>
	</form>

<?php
	if (!empty($_GET['upc'])){
		$upcStr = validate_input_field($_GET['upc']);
		if (is_numeric($upcStr)){
			$upcInt = (int) $upcStr;
			if ($upcInt >= 0 && $upcInt <= 999999999999){
				conn_exec_query(
					'gen_table_from_select', 
					"SELECT * FROM product WHERE upc=" 
					. $upcInt . ";");
			} else {
				echo "<b class=\"error\">Input field out of range: upc</b><br/>";
			}
		} else {
			echo "<b class=\"error\">Input field must be a 12 digit integer</b><br/>";
		} 
		
	} else if (!empty($_GET['prod_name'])){
		$nameSearchStr = validate_input_field($_GET['prod_name']);
		if (ctype_alpha($nameSearchStr)){
			conn_exec_query(
				'gen_table_from_select',
				"SELECT * FROM product WHERE name LIKE \"%"
				. $nameSearchStr . "%\";");
		} else {
			echo "<b class=\"error\">Input field must contain all alphabetic characters</b>";
		}
	} else {
		//gen_table_from_select("SELECT * FROM product;");
		conn_exec_query(
			'gen_table_from_select',
			"SELECT * FROM product;");
	}
?>

	</body>
</html>

<?php
// validate string before passing it to html form
function validate_input_field($urlStr){

	return htmlspecialchars(
		stripslashes(
			trim(
				$urlStr
			)
		)
	);
}

// connect to database, execute query, and run callback
// function on the result. return whatever the callback 
// returns
function conn_exec_query ($callBack, $queryStr){
	$servername = "localhost";
	$username = "root";
	$password = NULL;
	$dbname = "ZombiePharmacy";

	$conn = mysqli_connect($servername, $username, $password, $dbname);

	if (!$conn){
		echo "Error: connection to database could not be made<br/>" .
			"<a href=\"/index.php\">Return to home</a>";
	} else {
		$result = mysqli_query($conn, $queryStr);

		// call callback function here
		$ret = call_user_func($callBack, $result);

		mysqli_free_result($result);
		mysqli_close($conn);
	}
	return $ret;
}

// get primary key of a tuple as string 
// where result is the result set of a SELECT query
function search_primary_key ($result){

	$numRows = mysqli_num_rows($result);

	if ($numRows == 1){
		return mysqli_fetch_row($result)[0];
	} else {
		return NULL;
	}
}

// make a table from a result set of a SELECT query
function gen_table_from_select ($result, $linkToViewRow=true)
{
	$fieldInfo = mysqli_fetch_fields($result);
?>
	<br/>
	<table>
		<tr>
<?php
	// print column headers
	foreach ($fieldInfo as $f)
		echo  "<th>" . $f->name . "</th>";
?>
		</tr>
<?php
	// print the tuples of data
	while (!empty($row = mysqli_fetch_row($result))){

		echo "<tr>";

		// let primary key attribute be a link to 
		// "/view_(tablename).php?(primkeyattr)=(value)"
		if ($linkToViewRow){
			echo "<td>" ."<a " . "href=\"/view_" . $fieldInfo[0]->table 
				. ".php?" . $fieldInfo[0]->name . "="
				. $row[0] . "\">" .  $row[0] . "</a></td>";

			for($attr=1; $attr < count($row); $attr++){
				echo "<td>" . $row[$attr] . "</td>";
			}
		// no link
		} else {
			foreach ($row as $attr){
				echo "<td>" . $attr . "</td>";
			}
		}
		echo "</tr>";
	}
?>
	</table>
<?php
}
?>

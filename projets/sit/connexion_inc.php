<?php

$mysqli = @new Mysqli("sql2.olympe.in","z8sl8dun", "toor","z8sl8dun");
//$mysqli = @new Mysqli("localhost","root", "","membre");

if($mysqli->connect_error)
	{
		die("Un prob de connexion à la BDD:" . $mysqli->connect_error);
	}
<!DOCTYPE html lang="fr">
<html>
<head>
	<title>
		Commentaire
	</title>
	<meta charset="utf-8" />
	<style>
		body{
			background: #000;
		}
		.erreur{
			background: white;
			display: inline;
			padding: 7px;
			label{float: left; width: 80px;}
		}
		.clear{
			clear: both;
		}

		#comm{
			color: pink;
			text-align: center;
			padding: 20px;
			margin: 0 auto;
			text-decoration: underline;
			font-family: Helvetica, calibri , sans-serif;
		}
		.pseudo{
			color: tomato;
			text-align: center;
			padding: 10px;
			margin: 0 auto;
			font-family: Helvetica, calibri , sans-serif;
			font-weight: 9px;
			font-style: italic;
			
		}
		.mess{
			color: green;
			text-align: center;
			padding: 10px;
			margin: 0 auto;
			font-family: Helvetica;
			font-weight: 7px;
			
		}
		.date{
			float: left;

		}

		}
		.container{
			margin: 0 auto;
			padding: 10px; 

		}
	</style>
</head>

<body>
<?php
$mysqli = new Mysqli("localhost","root","","commentaire"); 
$msg="";
/*if(!empty($_POST)){
	echo "<p>" . $_POST['pseudo'] ."</p>";
	
	echo "<p>" . $_POST['commentaire'] ."</p>";
	echo "<br/>";
	 
}*/		


if(!empty($_POST)){
$verif_carac = preg_match('#^[a-zA-Z0-9_-]+$#',$_POST['pseudo']); /* expression régulière, puis la localisation */
}
if(!empty($_POST['pseudo'])&&$verif_carac&&!empty($_POST['commentaire'])){
	$_POST['pseudo']= htmlentities($_POST['pseudo'],ENT_QUOTES);/* AntiHacker*/
	$_POST['commentaire']= htmlentities($_POST['commentaire'],ENT_QUOTES);

	$pseudo= $_POST['pseudo'];
	$commentaire = $_POST['commentaire'];
	

	$mysqli->query( "INSERT INTO commentaire(pseudo, message,date) VALUES('$pseudo', '$commentaire', now() )	"  );	
	
	echo $mysqli->error;
	$msg ="<div class='erreur' > Commentaire notifié</div";

}else{
	$msg = "<div class='erreur' > Veuillez saisir les 2 champs pour votre commentaire soit pris en compte</div>";
}




?>

<div class="container">
	<iframe width="560" height="315" src="//www.youtube.com/embed/HZboT2ZvKDU" frameborder="0" allowfullscreen></iframe>
</div>

<div .clear></div>
<h2 id="comm">Commentaire</h2>



<?php
	$resultat = $mysqli->query("SELECT pseudo, message, date_format(date,'%d-%m-%Y') as datefr, date_format(date,'%H-%i-%s') as heurefr FROM commentaire ORDER BY date DESC");	
	while ($comments = $resultat -> fetch_assoc()) {
			
			
			echo "<div class='pseudo'>Par: " . $comments['pseudo'] . "</p>";
			
			echo "<p class='mess'>Commentaire: " . $comments['message'] . " "."</p>";
			echo "<p class='date'>Date: " . $comments['datefr'] . "</p>";
			echo "<p class='date'> à  " . $comments['heurefr'] . "</p>";
			echo "<div class='clear'></div>";
			echo "<hr/>";
		}	



?>
<div .clear></div>

<form method="post" action="">
	<?php echo $msg; ?>
	<div class="clear"></div>
	<label for="pseudo">Pseudo</label>
	<input type="text" name="pseudo" id="pseudo" placeholder="Votre pseudo">
	<br/>
	<label for="commentaire">Commentaire</label>
	<textarea type="text" name="commentaire" id="commentaire" placeholder="Votre Commentaire"></textarea>
	<br/>

	<input type="submit" name="commenter" value="Commenter">

</form>


</body>



</html>


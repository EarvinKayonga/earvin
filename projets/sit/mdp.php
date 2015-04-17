<?php
require_once("init_inc.php");


if(empty($_GET) == false){
	if (!empty($_GET['id_utilisateur'])) {
		if ($_POST) {
	$_GET['id_utillisateur']=htmlentities($_GET['id_utilisateur'],ENT_QUOTES);
	$_POST['mdp']=htmlentities($_POST['mdp'],ENT_QUOTES);

	foreach ($_POST as $key => $value) {
			$_POST[$key] = htmlentities($value,ENT_QUOTES);
			
		}

		$mdp=$_POST['mdp'];
		$id_utilisateur=$_GET['id_utilisateur'];
		$req = "UPDATE utilisateur SET mdp='$mdp' WHERE id_utilisateur='$id_utilisateur' ";
		execute_requete($req);
		
		$msg .= "<div class='b'>Changement effectuee<div>";
		
		header("location:profil.php");
	}else{
		var_dump($_POST);
		var_dump($_GET);
		//premiere connexion
	}
}else{
		echo '<p class=b>Erreur avec votre pseudo2</p>';
		exit;
}

}
require_once("haut_de_site_inc.php");
echo $msg;


?>

<form class="secret" method="post" >
	
	
	<label for="mdp">Mot de passe</label>
		<input id="mdp" type="password" placeholder="Votre mot de passe" type="text" name="mdp" required /><br/>
	<br>

	<button type="submit" class="btn btn-primary">Changer</button> 
</form>

</body>
</html>
<?php
require_once("init_inc.php");
if ($_POST) {
	$_POST['pseudo']=htmlentities($_POST['pseudo'],ENT_QUOTES);
	$_POST['mdp']=htmlentities($_POST['mdp'],ENT_QUOTES);
	$resultat = execute_requete("SELECT * FROM utilisateur WHERE pseudo ='$_POST[pseudo]' and mdp='$_POST[mdp]'");
	if ($resultat->num_rows>0) {
		$membre = $resultat->fetch_assoc();
		foreach ($membre as $indice => $valuer) {
			$_SESSION['utilisateur'][$indice]=$valuer;
		}
		header("location:profil.php");
	}else{
		$msg .= "Erreur d'identification";
	}
}
require_once("haut_de_site_inc.php");
require_once("menu_inc.php");
echo $msg;
?>


<form method="post" >
	<label for="pseudo">Pseudo</label>
		<input id="pseudo" placeholder="Votre pseudo" type="text" name="pseudo" required/>
	
	<label for="mdp">Mot de passe</label>
		<input id="mdp" type="password" placeholder="Votre mot de passe" type="text" name="mdp" required /><br/>
	<br>

	<button type="submit" class="btn btn-primary">Connexion</button> 
</form>

<br/>

<br/>

<p class="affair"> Portail</p>
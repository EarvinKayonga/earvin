<?php
	require_once("init_inc.php");
	//debug($_POST);
	if (!empty($_POST)){ /* Est ce qu'on il y a soumission*/
		foreach ($_POST as $key => $value) {
			$_POST[$key] = htmlentities($value,ENT_QUOTES);
			
		}
		
		$resultat = execute_requete("SELECT * FROM utilisateur WHERE pseudo ='$_POST[pseudo]'");
	

		if ($resultat->num_rows==0) {
			execute_requete("INSERT INTO utilisateur(pseudo, mdp, prenom, nom, email ) VALUES('$_POST[pseudo]','$_POST[mdp]','$_POST[prenom]','$_POST[nom]','$_POST[mail]')" );
			$msg .= "<div class='validation'>Inscription okay<div>";
			echo $msg;
			header("location:connexion.php");
		}
		$msg .= "<div class='validation'>Ce pseudo existe déjà<div>";
		echo $msg;
	}else{
		$msg .= "<div class='validation'>Formulaire vide<div>";
		
	}
	require_once("haut_de_site_inc.php");
	require_once("menu_inc.php");
	
?>


	<div class="row">
	<form class="form" role="form" method="post" action="">
		<div class="form-group">
		<label for="pseudo"  >Pseudo</label>
		<br/>
		<input id="pseudo" placeholder="Votre pseudo" type="text" name="pseudo" required/>
		</div>
		
		<div class="form-group">
		<label for="mdp" >Mot de passe</label>
		<br/>
		<input id="mdp" type="password" placeholder="Votre mot de passe" type="text" name="mdp" required/>
		</div>

		
		<div class="form-group">
		<label for="mail" >Email</label>
		<br/>
		<input id="mail" placeholder="Votre email" type="email" name="mail" required/>
		</div>

		
		<div class="form-group">

		<label for="nom" >Nom</label>
		<br/>
		<input id="nom" placeholder="Votre nom" type="text" name="nom" required/>
		</div>
		
		<div class="form-group">
		<label for="prenom" >Prenom</label>
		<br/>
		<input id="prenom" placeholder="Votre prenom" type="text" name="prenom" required/>
		</div>
		<br/>

		<button type="submit" class="btn btn-primary">Envoyer</button> 

		<!---<input  value="Envoyer" type="submit" />-->
	</form>
	</div>


</div>
</body>
</html>
<ul class="nav nav-pills">
<?php
	if (utilisateur_est_connecte()) {
		?>
			
			<li role="presentation" class="active"><a href="profil.php">Profil</a></li>
			<li role="presentation" class="active"><a href="decon.php">Deconnexion</a></li>
		<?php
	}else{
		?>
			<li role="presentation"><a href="inscription.php">Inscription</a></li>
 			<li role="presentation"><a href="connexion.php">Connexion</a></li>
		<?php
		}
?>
</ul>

 
 

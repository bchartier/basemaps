<!DOCTYPE html>
<html>
	<head>
		<title>Editeur Basemaps</title>
		<meta name="viewport" content="width=device-width, initial-scale=1.0">
		<meta charset="utf-8">

		<!-- Latest compiled and minified CSS -->
		<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap.min.css">

		<!-- Optional theme -->
		<link rel="stylesheet" href="//netdna.bootstrapcdn.com/bootstrap/3.0.0/css/bootstrap-theme.min.css">
	</head>
	<body>
		<div class="row">
			<div class="col-md-4">
				<h2>style {$style}</h2>
				<ul>
				{foreach from=$cles item=cle}
					<li><a href="?p_style={$style}&directive={$cle}">{$cle}</a></li>
				{/foreach}
				</ul>
			</div>
			<div class="col-md-8">
				{if $directive}
					<h1>{$directive}</h1>
					<fieldset><legend>Valeur de base</legend>
					{if $base_is_array}
						<table>
							<tr>
								<th>k</th>
								<th>v</th>
							</tr>
						{foreach from=$base item=v key=k}
							<tr>
								<td>{$k}</td>
								<td>{$v}</td>
							</tr>
						{/foreach}
						</table>
					{else}
						{$base}
					{/if}
					</fieldset>
					<fieldset><legend>Valeur du style</legend>
					{if !$style_is_set}
						<h4>Pas de valeur personnalisée pour le style "{$style}"</h4>
						<!-- todo formulaire ajout -->
					{else}
						{if $style_is_array}
							<!-- todo tableau editable -->
						{else}
							{$style_val}
						{/if}
					{/if}
					</fieldset>
				{/if}
			</div>
		</div>
		<!-- Latest compiled and minified JavaScript -->
		<script src="//code.jquery.com/jquery.js"></script>
		<script src="//netdna.bootstrapcdn.com/bootstrap/3.0.0/js/bootstrap.min.js"></script>
	</body>
</html>

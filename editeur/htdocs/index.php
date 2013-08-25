<?php
require_once('smarty3/Smarty.class.php');
$p_style = isset($_GET['p_style'])?$_GET['p_style']:'default';

$base = json_decode(file_get_contents("../../json/base.json"), true);
$styles = json_decode(file_get_contents("../../json/styles.json"), true);
$style_aliases = json_decode(file_get_contents("../../json/style_aliases.json"), true);


$smarty = new Smarty();
$smarty->template_dir = "../templates/";
$smarty->cache_dir = "/tmp/basemaps_cache/";
$smarty->compile_dir = "/tmp/basemaps_compile/";

if (!file_exists($smarty->cache_dir)) mkdir($smarty->cache_dir);
if (!file_exists($smarty->compile_dir)) mkdir($smarty->compile_dir);

$smarty->assign('style', $p_style);
$cles = array_merge(array_keys($base), array_keys($styles[$p_style]));
sort($cles);
$smarty->assign('cles', $cles);

if (!isset($_GET['directive'])) {
	$smarty->assign('directive', false);
} else {
	$base = $base[$_GET['directive']];
	$smarty->assign('directive', $_GET['directive']);
	
	$smarty->assign('base', $base);
	$smarty->assign('base_is_array', is_array($base));
	$style_is_set = isset($styles[$p_style][$_GET['directive']]);
	$smarty->assign('style_is_set', $style_is_set);
	if ($style_is_set) {
		$s = $styles[$p_style][$_GET['directive']];
		$smarty->assign('style_is_array', is_array($s));
		$smarty->assign('style_val', $s);
	}
}

$smarty->display('index.tpl');


?>

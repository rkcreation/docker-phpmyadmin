<?php
// require('./config.secret.inc.php');

/* Uploads setup */
$cfg['UploadDir'] = isset($_ENV['UPLOAD_PATH']) ? $_ENV['UPLOAD_PATH'] :'/backups';
$cfg['SaveDir'] = '';

/* Theme Metro */
$cfg['ThemeManager'] = false;
$cfg['ThemeDefault'] = 'fallen';

/* Login validity */
$cfg['LoginCookieValidity'] = 24 * 3600;

/* Export default config */
$cfg['Export']['method'] = 'custom';
$cfg['Export']['compression'] = 'zip';
$cfg['Export']['file_template_table'] = ( isset($_ENV['STACK_NAME']) ? str_replace('.','-',$_ENV['STACK_NAME']) : 'dev' ) . ( isset($_ENV['APPLICATION_ENV']) ? '-'.$_ENV['APPLICATION_ENV'] : '' ) . '--@DATABASE@--@TABLE@--%F--%H-%M-%S';
$cfg['Export']['file_template_database'] = ( isset($_ENV['STACK_NAME']) ? str_replace('.','-',$_ENV['STACK_NAME']) : 'dev' ) . ( isset($_ENV['APPLICATION_ENV']) ? '-'.$_ENV['APPLICATION_ENV'] : '' ) . '--@DATABASE@--%F--%H-%M-%S';
$cfg['Export']['file_template_server'] = ( isset($_ENV['STACK_NAME']) ? str_replace('.','-',$_ENV['STACK_NAME']) : 'dev' ) . ( isset($_ENV['APPLICATION_ENV']) ? '-'.$_ENV['APPLICATION_ENV'] : '' ) . '--server--@SERVER@--%F--%H-%M-%S';
$cfg['Export']['sql_drop_table'] = true;

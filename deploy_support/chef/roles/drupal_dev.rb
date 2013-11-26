name "drupal_dev"
description "A LAMP development enviroment for Drupal."

run_list "recipe[apt::default]", "recipe[build-essential]", "recipe[vagrant_drupal]"
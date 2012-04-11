/*
 Navicat Premium Data Transfer

 Source Server         : hades.local
 Source Server Type    : MySQL
 Source Server Version : 50155
 Source Host           : localhost
 Source Database       : zoolicious

 Target Server Type    : MySQL
 Target Server Version : 50155
 File Encoding         : utf-8

 Date: 04/04/2012 13:25:00 PM
*/

SET NAMES utf8;
SET FOREIGN_KEY_CHECKS = 0;

-- ----------------------------
--  Table structure for `animals`
-- ----------------------------
DROP TABLE IF EXISTS `animals`;
CREATE TABLE `animals` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `cuteness` int(11) DEFAULT '1',
  `habitat_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `animals`
-- ----------------------------
BEGIN;
INSERT INTO `animals` VALUES ('1', 'Banshee', 'Apparently in terms of clothing, she either wears a grey, hooded cloak or a grave robe meant for the unshriven dead. Those who where not allowed to find \"absolution.\"', '1', '1'), ('2', 'Sea Dragon', 'Not to be confused with the sea horse, these grim creatures are capable of withstanding very hot temperatures.', '3', '2');
COMMIT;

-- ----------------------------
--  Table structure for `animals_feeds`
-- ----------------------------
DROP TABLE IF EXISTS `animals_feeds`;
CREATE TABLE `animals_feeds` (
  `animal_id` int(11) NOT NULL,
  `feed_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `animals_feeds`
-- ----------------------------
BEGIN;
INSERT INTO `animals_feeds` VALUES ('1', '1'), ('2', '2');
COMMIT;

-- ----------------------------
--  Table structure for `animals_users`
-- ----------------------------
DROP TABLE IF EXISTS `animals_users`;
CREATE TABLE `animals_users` (
  `animal_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL
) ENGINE=MyISAM DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `animals_users`
-- ----------------------------
BEGIN;
INSERT INTO `animals_users` VALUES ('1', '1'), ('1', '2'), ('1', '3'), ('1', '4'), ('1', '5'), ('1', '6'), ('2', '1'), ('2', '2'), ('2', '3'), ('2', '4'), ('2', '5'), ('2', '6'), ('2', '7'), ('2', '8');
COMMIT;

-- ----------------------------
--  Table structure for `feeds`
-- ----------------------------
DROP TABLE IF EXISTS `feeds`;
CREATE TABLE `feeds` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `delicious` int(11) DEFAULT '0',
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `feeds`
-- ----------------------------
BEGIN;
INSERT INTO `feeds` VALUES ('1', 'Human Souls', '0'), ('2', 'Molten Seaweed', '0');
COMMIT;

-- ----------------------------
--  Table structure for `habitats`
-- ----------------------------
DROP TABLE IF EXISTS `habitats`;
CREATE TABLE `habitats` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  `capacity` int(11) NOT NULL DEFAULT '1',
  `location` varchar(255) DEFAULT NULL,
  `description` varchar(255) DEFAULT NULL,
  `zoo_id` int(11) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB AUTO_INCREMENT=3 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `habitats`
-- ----------------------------
BEGIN;
INSERT INTO `habitats` VALUES ('1', 'Haunted Habitat', '10', 'West Wing past the forest of lies', 'A very scary place filled with disgusting cobwebs and broken glass.', '1'), ('2', 'Boiling Aquatic', '3', 'Next to the live volcano past the garden of mucky-muck.', 'A bubbling pool of hot water in which only the toughest can swim in.', '1');
COMMIT;

-- ----------------------------
--  Table structure for `tests`
-- ----------------------------
DROP TABLE IF EXISTS `tests`;
CREATE TABLE `tests` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=2 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `tests`
-- ----------------------------
BEGIN;
INSERT INTO `tests` VALUES ('1', 'Morpheus');
COMMIT;

-- ----------------------------
--  Table structure for `users`
-- ----------------------------
DROP TABLE IF EXISTS `users`;
CREATE TABLE `users` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(255) DEFAULT NULL,
  `password` varchar(255) DEFAULT NULL,
  `first_name` varchar(255) DEFAULT NULL,
  `last_name` varchar(255) DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=11 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `users`
-- ----------------------------
BEGIN;
INSERT INTO `users` VALUES ('1', 'jburkhart', 'password', 'Jackie', 'Burkhart'), ('2', 'fez', 'password', 'Fez', null), ('3', 'eforman', 'password', 'Eric', 'Forman'), ('4', 'kforman', 'password', 'Kitty', 'Forman'), ('5', 'lforman', 'password', 'Laurie', 'Forman'), ('6', 'rforman', 'password', 'Red', 'Forman'), ('7', 'shyde', 'password', 'Steven', 'Hyde'), ('8', 'mkelso', 'password', 'Michael', 'Kelso'), ('9', 'leo', 'password', 'Leo', null), ('10', 'dpinciotti', 'password', 'Donna', 'Pinciotti');
COMMIT;

-- ----------------------------
--  Table structure for `zoos`
-- ----------------------------
DROP TABLE IF EXISTS `zoos`;
CREATE TABLE `zoos` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(255) NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=MyISAM AUTO_INCREMENT=6 DEFAULT CHARSET=latin1;

-- ----------------------------
--  Records of `zoos`
-- ----------------------------
BEGIN;
INSERT INTO `zoos` VALUES ('1', 'Zoo of Mirrors');
COMMIT;


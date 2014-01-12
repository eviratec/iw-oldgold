-- phpMyAdmin SQL Dump
-- version 3.3.3
-- http://www.phpmyadmin.net
--
-- Host: localhost
-- Generation Time: Jun 19, 2010 at 05:56 PM
-- Server version: 5.1.41
-- PHP Version: 5.3.2-1ubuntu4.2

SET SQL_MODE="NO_AUTO_VALUE_ON_ZERO";


/*!40101 SET @OLD_CHARACTER_SET_CLIENT=@@CHARACTER_SET_CLIENT */;
/*!40101 SET @OLD_CHARACTER_SET_RESULTS=@@CHARACTER_SET_RESULTS */;
/*!40101 SET @OLD_COLLATION_CONNECTION=@@COLLATION_CONNECTION */;
/*!40101 SET NAMES utf8 */;

--
-- Database: `iwSchemata`
--

-- --------------------------------------------------------

--
-- Table structure for table `address`
--

CREATE TABLE IF NOT EXISTS `address` (
  `addressID` int(11) NOT NULL AUTO_INCREMENT,
  `firstLine` varchar(45) NOT NULL,
  `secondLine` varchar(45) DEFAULT NULL,
  `city` varchar(45) NOT NULL,
  `stateID` int(11) NOT NULL,
  `postcode` varchar(12) NOT NULL,
  PRIMARY KEY (`addressID`),
  KEY `STATE` (`stateID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `address`
--

INSERT INTO `address` (`addressID`, `firstLine`, `secondLine`, `city`, `stateID`, `postcode`) VALUES
(1, '9 Willow Avenue', NULL, 'Mitcham', 7, '3132');

-- --------------------------------------------------------

--
-- Table structure for table `company`
--

CREATE TABLE IF NOT EXISTS `company` (
  `companyID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `status` varchar(45) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  PRIMARY KEY (`companyID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `company`
--

INSERT INTO `company` (`companyID`, `name`, `status`, `dateCreated`, `dateLastModified`) VALUES
(1, 'Integrated Web Services', 'ACTIVE', '2010-06-14 13:19:44', '2010-06-14 13:19:48');

-- --------------------------------------------------------

--
-- Table structure for table `companyAddress`
--

CREATE TABLE IF NOT EXISTS `companyAddress` (
  `companyAddressID` int(11) NOT NULL AUTO_INCREMENT,
  `companyID` int(11) NOT NULL,
  `addressID` int(11) NOT NULL,
  `dateFrom` datetime NOT NULL,
  `dateThru` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  PRIMARY KEY (`companyAddressID`),
  KEY `COMPANY` (`companyID`),
  KEY `ADDRESS` (`addressID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `companyAddress`
--

INSERT INTO `companyAddress` (`companyAddressID`, `companyID`, `addressID`, `dateFrom`, `dateThru`, `dateCreated`, `dateLastModified`) VALUES
(1, 1, 1, '2010-06-14 14:39:27', NULL, '2010-06-14 14:39:27', '2010-06-14 14:39:27');

-- --------------------------------------------------------

--
-- Table structure for table `contact`
--

CREATE TABLE IF NOT EXISTS `contact` (
  `contactID` int(11) NOT NULL AUTO_INCREMENT,
  `firstName` varchar(45) NOT NULL,
  `lastName` varchar(45) NOT NULL,
  `primaryEmail` varchar(100) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  PRIMARY KEY (`contactID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `contact`
--

INSERT INTO `contact` (`contactID`, `firstName`, `lastName`, `primaryEmail`, `dateCreated`, `dateLastModified`) VALUES
(1, 'Callan', 'Milne', 'callan.milne@integratedweb.com.au', '2010-06-14 13:27:15', '2010-06-14 13:27:15');

-- --------------------------------------------------------

--
-- Table structure for table `contactAddress`
--

CREATE TABLE IF NOT EXISTS `contactAddress` (
  `contactAddressID` int(11) NOT NULL AUTO_INCREMENT,
  `contactID` int(11) NOT NULL,
  `addressID` int(11) NOT NULL,
  `dateFrom` datetime NOT NULL,
  `dateThru` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  PRIMARY KEY (`contactAddressID`),
  KEY `CONTACT` (`contactID`),
  KEY `ADDRESS` (`addressID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `contactAddress`
--

INSERT INTO `contactAddress` (`contactAddressID`, `contactID`, `addressID`, `dateFrom`, `dateThru`, `dateCreated`, `dateLastModified`) VALUES
(1, 1, 1, '2010-06-14 13:49:44', NULL, '2010-06-14 13:49:44', '2010-06-14 13:49:44');

-- --------------------------------------------------------

--
-- Table structure for table `contactAttribute`
--

CREATE TABLE IF NOT EXISTS `contactAttribute` (
  `contactID` int(11) NOT NULL,
  `attrTypeID` varchar(32) NOT NULL,
  `attrValue` varchar(90) NOT NULL,
  `dateAttrFrom` datetime NOT NULL,
  `dateAttrThru` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  KEY `ATTRIBUTE TYPE` (`attrTypeID`),
  KEY `CONTACT` (`contactID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contactAttribute`
--

INSERT INTO `contactAttribute` (`contactID`, `attrTypeID`, `attrValue`, `dateAttrFrom`, `dateAttrThru`, `dateCreated`, `dateLastModified`) VALUES
(1, 'PHONE-MOBILE', '0425612264', '2010-06-14 13:49:44', NULL, '2010-06-14 13:49:44', '2010-06-14 13:49:44'),
(1, 'PHONE-OFFICE', '0425612264', '2010-06-14 13:49:44', NULL, '2010-06-14 13:49:44', '2010-06-14 13:49:44'),
(1, 'PHONE-OTHER', '0398732860', '2010-06-14 13:49:44', NULL, '2010-06-14 13:49:44', '2010-06-14 13:49:44'),
(1, 'PRIMARY-EMAIL', 'callan.milne@integratedweb.com.au', '2010-06-14 13:49:44', NULL, '2010-06-14 13:49:44', '2010-06-14 13:49:44'),
(1, 'SECONDARY-EMAIL', 'kounterfeitreality@gmail.com', '2010-06-14 13:49:44', NULL, '2010-06-14 13:49:44', '2010-06-14 13:49:44');

-- --------------------------------------------------------

--
-- Table structure for table `contactAttributeType`
--

CREATE TABLE IF NOT EXISTS `contactAttributeType` (
  `attrTypeID` varchar(32) NOT NULL,
  `attrParentTypeID` varchar(32) DEFAULT NULL,
  `attrName` varchar(45) NOT NULL,
  `attrDescription` varchar(90) DEFAULT NULL,
  `attrExample` varchar(45) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  PRIMARY KEY (`attrTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contactAttributeType`
--

INSERT INTO `contactAttributeType` (`attrTypeID`, `attrParentTypeID`, `attrName`, `attrDescription`, `attrExample`, `dateCreated`, `dateLastModified`) VALUES
('PHONE-MOBILE', NULL, 'Phone (Mobile)', 'Mobile phone number', '0412456789', '2010-06-14 13:30:40', '2010-06-14 13:30:40'),
('PHONE-OFFICE', NULL, 'Phone (Office)', 'Phone number for contact during business hours', '0390001111', '2010-06-14 13:30:40', '2010-06-14 13:30:40'),
('PHONE-OTHER', NULL, 'Phone (Other)', 'Phone number for contact outside business hours', '0390002222', '2010-06-14 13:30:40', '2010-06-14 13:30:40'),
('PRIMARY-EMAIL', NULL, 'Primary Email', 'Primary contact email address', 'user@domain.com', '2010-06-14 13:30:40', '2010-06-14 13:30:40'),
('SECONDARY-EMAIL', NULL, 'Secondary Email', 'Secondary contact email address', 'user@domain.com', '2010-06-14 13:30:40', '2010-06-14 13:30:40');

-- --------------------------------------------------------

--
-- Table structure for table `contactLogin`
--

CREATE TABLE IF NOT EXISTS `contactLogin` (
  `contactID` int(11) NOT NULL,
  `username` varchar(32) NOT NULL,
  `password` varchar(64) NOT NULL,
  `dateLastLogin` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  KEY `CONTACT` (`contactID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contactLogin`
--

INSERT INTO `contactLogin` (`contactID`, `username`, `password`, `dateLastLogin`, `dateCreated`, `dateLastModified`) VALUES
(1, 'callan.milne', 'kazahak', NULL, '2010-06-14 13:58:25', '2010-06-14 13:58:25');

-- --------------------------------------------------------

--
-- Table structure for table `contactType`
--

CREATE TABLE IF NOT EXISTS `contactType` (
  `contactTypeID` varchar(16) NOT NULL,
  `contactType` varchar(32) NOT NULL,
  `description` varchar(45) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  PRIMARY KEY (`contactTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `contactType`
--

INSERT INTO `contactType` (`contactTypeID`, `contactType`, `description`, `dateCreated`, `dateLastModified`) VALUES
('BILLING', 'Billing Contact', 'The billing contact for this account', '2010-06-14 13:58:25', '2010-06-14 13:58:25'),
('PRIMARY', 'Primary Contact', 'The primary contact for this account', '2010-06-14 13:58:25', '2010-06-14 13:58:25'),
('SECONDARY', 'Secondary Contact', 'The secondary contact for this account', '2010-06-14 13:58:25', '2010-06-14 13:58:25'),
('TECHNICAL', 'Technical Contact', 'The technical contact for this account', '2010-06-14 13:58:25', '2010-06-14 13:58:25');

-- --------------------------------------------------------

--
-- Table structure for table `customer`
--

CREATE TABLE IF NOT EXISTS `customer` (
  `customerID` int(11) NOT NULL AUTO_INCREMENT,
  `companyID` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  PRIMARY KEY (`customerID`),
  KEY `COMPANY` (`companyID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=3 ;

--
-- Dumping data for table `customer`
--

INSERT INTO `customer` (`customerID`, `companyID`, `dateCreated`, `dateLastModified`) VALUES
(2, 1, '2010-06-14 13:24:52', '2010-06-14 13:24:55');

-- --------------------------------------------------------

--
-- Table structure for table `customerContact`
--

CREATE TABLE IF NOT EXISTS `customerContact` (
  `customerContactID` int(11) NOT NULL AUTO_INCREMENT,
  `customerID` int(11) NOT NULL,
  `contactID` int(11) NOT NULL,
  `contactTypeID` varchar(16) NOT NULL,
  `dateFrom` datetime NOT NULL,
  `dateThru` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  PRIMARY KEY (`customerContactID`),
  KEY `CONTACTTYPE` (`contactID`,`contactTypeID`),
  KEY `CUSTOMER` (`customerID`),
  KEY `CONTACT` (`contactID`),
  KEY `CONTACT TYPE` (`contactTypeID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `customerContact`
--

INSERT INTO `customerContact` (`customerContactID`, `customerID`, `contactID`, `contactTypeID`, `dateFrom`, `dateThru`, `dateCreated`, `dateLastModified`) VALUES
(1, 2, 1, 'PRIMARY', '2010-06-14 15:51:39', NULL, '2010-06-14 15:51:39', '2010-06-14 15:51:39');

-- --------------------------------------------------------

--
-- Table structure for table `customerInvoice`
--

CREATE TABLE IF NOT EXISTS `customerInvoice` (
  `customerID` int(11) NOT NULL,
  `invoiceID` int(11) NOT NULL,
  KEY `CUSTOMER` (`customerID`),
  KEY `INVOICE` (`invoiceID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `customerInvoice`
--

INSERT INTO `customerInvoice` (`customerID`, `invoiceID`) VALUES
(2, 1);

-- --------------------------------------------------------

--
-- Table structure for table `customerWebsite`
--

CREATE TABLE IF NOT EXISTS `customerWebsite` (
  `customerWebsiteID` int(11) NOT NULL AUTO_INCREMENT,
  `customerID` int(11) NOT NULL,
  `websiteID` int(11) NOT NULL,
  `dateFrom` datetime NOT NULL,
  `dateThru` datetime DEFAULT NULL,
  PRIMARY KEY (`customerWebsiteID`),
  KEY `CUSTOMER` (`customerID`),
  KEY `WEBSITE` (`websiteID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `customerWebsite`
--

INSERT INTO `customerWebsite` (`customerWebsiteID`, `customerID`, `websiteID`, `dateFrom`, `dateThru`) VALUES
(1, 2, 1, '2010-06-14 15:51:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `dataCountry`
--

CREATE TABLE IF NOT EXISTS `dataCountry` (
  `countryID` int(11) NOT NULL AUTO_INCREMENT,
  `countryName` varchar(90) NOT NULL,
  PRIMARY KEY (`countryID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=251 ;

--
-- Dumping data for table `dataCountry`
--

INSERT INTO `dataCountry` (`countryID`, `countryName`) VALUES
(1, 'Afghanistan'),
(2, 'Albania'),
(3, 'Algeria'),
(4, 'American Samoa'),
(5, 'Andorra'),
(6, 'Angola'),
(7, 'Anguilla'),
(8, 'Antarctica'),
(9, 'Antigua and Barbuda'),
(10, 'Argentina'),
(11, 'Armenia'),
(12, 'Aruba'),
(13, 'Ascension Island'),
(14, 'Australia'),
(15, 'Austria'),
(16, 'Azerbaijan'),
(17, 'Bahamas'),
(18, 'Bahrain'),
(19, 'Bangladesh'),
(20, 'Barbados'),
(21, 'Belarus'),
(22, 'Belgium'),
(23, 'Belize'),
(24, 'Benin'),
(25, 'Bermuda'),
(26, 'Bhutan'),
(27, 'Bolivia'),
(28, 'Bosnia and Herzegovina'),
(29, 'Botswana'),
(30, 'Bouvet Island'),
(31, 'Brazil'),
(32, 'British Indian Ocean Territory'),
(33, 'Brunei Darussalam'),
(34, 'Bulgaria'),
(35, 'Burkina Faso'),
(36, 'Burundi'),
(37, 'Cambodia'),
(38, 'Cameroon'),
(39, 'Canada'),
(40, 'Cape Verde'),
(41, 'Cayman Islands'),
(42, 'Central African Republic'),
(43, 'Chad'),
(44, 'Chile'),
(45, 'China'),
(46, 'Christmas Island'),
(47, 'Cocos (Keeling) Islands'),
(48, 'Colombia'),
(49, 'Comoros'),
(50, 'Democratic Republic of the Congo(Kinshasa)'),
(51, 'Congo, Republic of (Brazzaville)'),
(52, 'Cook Islands'),
(53, 'Costa Rica'),
(54, 'Ivory Coast'),
(55, 'Croatia'),
(56, 'Cuba'),
(57, 'Cyprus'),
(58, 'Czech Republic'),
(59, 'Denmark'),
(60, 'Djibouti'),
(61, 'Dominica'),
(62, 'Dominican Republic'),
(63, 'East Timor Timor-Leste'),
(64, 'Ecuador'),
(65, 'Egypt'),
(66, 'El Salvador'),
(67, 'Equatorial Guinea'),
(68, 'Eritrea'),
(69, 'Estonia'),
(70, 'Ethiopia'),
(71, 'Falkland Islands'),
(72, 'Faroe Islands'),
(73, 'Fiji'),
(74, 'Finland'),
(75, 'France'),
(76, 'French Guiana'),
(77, 'French Metropolitan'),
(78, 'French Polynesia'),
(79, 'French Southern Territories'),
(80, 'Gabon'),
(81, 'Gambia'),
(82, 'Georgia'),
(83, 'Germany'),
(84, 'Ghana'),
(85, 'Gibraltar'),
(86, 'Great Britain'),
(87, 'Greece'),
(88, 'Greenland'),
(89, 'Grenada'),
(90, 'Guadeloupe'),
(91, 'Guam'),
(92, 'Guatemala'),
(93, 'Guernsey'),
(94, 'Guinea'),
(95, 'Guinea-Bissau'),
(96, 'Guyana'),
(97, 'Haiti'),
(98, 'Heard and Mc Donald Islands'),
(99, 'Holy See'),
(100, 'Honduras'),
(101, 'Hong Kong'),
(102, 'Hungary'),
(103, 'Iceland'),
(104, 'India'),
(105, 'Indonesia'),
(106, 'Iran (Islamic Republic of)'),
(107, 'Iraq'),
(108, 'Ireland'),
(109, 'Isle of Man'),
(110, 'Israel'),
(111, 'Italy'),
(112, 'Jamaica'),
(113, 'Japan'),
(114, 'Jersey'),
(115, 'Jordan'),
(116, 'Kazakhstan'),
(117, 'Kenya'),
(118, 'Kiribati'),
(119, 'Korea, Democratic People''s Rep. (North Korea)'),
(120, 'Korea, Republic of (South Korea)'),
(121, 'Kuwait'),
(122, 'Kyrgyzstan'),
(123, 'Lao, People''s Democratic Republic'),
(124, 'Latvia'),
(125, 'Lebanon'),
(126, 'Lesotho'),
(127, 'Liberia'),
(128, 'Libya'),
(129, 'Liechtenstein'),
(130, 'Lithuania'),
(131, 'Luxembourg'),
(132, 'Macau'),
(133, 'Macedonia, Rep. of'),
(134, 'Madagascar'),
(135, 'Malawi'),
(136, 'Malaysia'),
(137, 'Maldives'),
(138, 'Mali'),
(139, 'Malta'),
(140, 'Marshall Islands'),
(141, 'Martinique'),
(142, 'Mauritania'),
(143, 'Mauritius'),
(144, 'Mayotte'),
(145, 'Mexico'),
(146, 'Micronesia, Federal States of'),
(147, 'Moldova, Republic of'),
(148, 'Monaco'),
(149, 'Mongolia'),
(150, 'Montenegro'),
(151, 'Montserrat'),
(152, 'Morocco'),
(153, 'Mozambique'),
(154, 'Myanmar, Burma'),
(155, 'Namibia'),
(156, 'Nauru'),
(157, 'Nepal'),
(158, 'Netherlands'),
(159, 'Netherlands Antilles'),
(160, 'New Caledonia'),
(161, 'New Zealand'),
(162, 'Nicaragua'),
(163, 'Niger'),
(164, 'Nigeria'),
(165, 'Niue'),
(166, 'Norfolk Island'),
(167, 'Northern Mariana Islands'),
(168, 'Norway'),
(169, 'Oman'),
(170, 'Pakistan'),
(171, 'Palau'),
(172, 'Palestinian National Authority'),
(173, 'Panama'),
(174, 'Papua New Guinea'),
(175, 'Paraguay'),
(176, 'Peru'),
(177, 'Philippines'),
(178, 'Pitcairn Island'),
(179, 'Poland'),
(180, 'Portugal'),
(181, 'Puerto Rico'),
(182, 'Qatar'),
(183, 'Reunion Island'),
(184, 'Romania'),
(185, 'Russian Federation'),
(186, 'Rwanda'),
(187, 'Saint Kitts and Nevis'),
(188, 'Saint Lucia'),
(189, 'Saint Vincent and the Grenadines'),
(190, 'Samoa'),
(191, 'San Marino'),
(192, 'Sao Tome and Príncipe'),
(193, 'Saudi Arabia'),
(194, 'Senegal'),
(195, 'Serbia'),
(196, 'Seychelles'),
(197, 'Sierra Leone'),
(198, 'Singapore'),
(199, 'Slovakia (Slovak Republic)'),
(200, 'Slovenia'),
(201, 'Solomon Islands'),
(202, 'Somalia'),
(203, 'South Africa'),
(204, 'South Georgia and South Sandwich Islands'),
(205, 'Spain'),
(206, 'Sri Lanka'),
(207, 'Saint Helena'),
(208, 'St. Pierre and Miquelon'),
(209, 'Sudan'),
(210, 'Suriname'),
(211, 'Svalbard and Jan Mayen Islands'),
(212, 'Swaziland'),
(213, 'Sweden'),
(214, 'Switzerland'),
(215, 'Syria, Syrian Arab Republic'),
(216, 'Taiwan (Republic of China)'),
(217, 'Tajikistan'),
(218, 'Tanzania'),
(219, 'Thailand'),
(220, 'Tibet'),
(221, 'Timor-Leste (East Timor)'),
(222, 'Togo'),
(223, 'Tokelau'),
(224, 'Tonga'),
(225, 'Trinidad and Tobago'),
(226, 'Tunisia'),
(227, 'Turkey'),
(228, 'Turkmenistan'),
(229, 'Turks and Caicos Islands'),
(230, 'Tuvalu'),
(231, 'Uganda'),
(232, 'Ukraine'),
(233, 'United Arab Emirates'),
(234, 'United Kingdom'),
(235, 'United States'),
(236, 'U.S. Minor Outlying Islands'),
(237, 'Uruguay'),
(238, 'Uzbekistan'),
(239, 'Vanuatu'),
(240, 'Vatican City State (Holy See)'),
(241, 'Venezuela'),
(242, 'Vietnam'),
(243, 'Virgin Islands (British)'),
(244, 'Virgin Islands (U.S.)'),
(245, 'Wallis and Futuna Islands'),
(246, 'Western Sahara'),
(247, 'Yemen'),
(248, 'Zaire (see Congo, Democratic People''s Republic)'),
(249, 'Zambia'),
(250, 'Zimbabwe');

-- --------------------------------------------------------

--
-- Table structure for table `dataCountryState`
--

CREATE TABLE IF NOT EXISTS `dataCountryState` (
  `stateID` int(11) NOT NULL AUTO_INCREMENT,
  `countryID` int(11) NOT NULL,
  `stateName` varchar(45) NOT NULL,
  PRIMARY KEY (`stateID`),
  KEY `COUNTRY` (`countryID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=9 ;

--
-- Dumping data for table `dataCountryState`
--

INSERT INTO `dataCountryState` (`stateID`, `countryID`, `stateName`) VALUES
(1, 14, 'Australian Capital Territory'),
(2, 14, 'New South Wales'),
(3, 14, 'Northern Territory'),
(4, 14, 'Queensland'),
(5, 14, 'South Australia'),
(6, 14, 'Tasmania'),
(7, 14, 'Victoria'),
(8, 14, 'Western Australia');

-- --------------------------------------------------------

--
-- Table structure for table `dataResource`
--

CREATE TABLE IF NOT EXISTS `dataResource` (
  `dataResourceID` int(11) NOT NULL AUTO_INCREMENT,
  `dataResourceTypeID` varchar(32) NOT NULL,
  `resourceID` int(11) NOT NULL,
  PRIMARY KEY (`dataResourceID`),
  KEY `DATA RESOURCE TYPE` (`dataResourceTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `dataResource`
--


-- --------------------------------------------------------

--
-- Table structure for table `dataResourceBigtext`
--

CREATE TABLE IF NOT EXISTS `dataResourceBigtext` (
  `bigtextID` int(11) NOT NULL AUTO_INCREMENT,
  `bigtext` longblob NOT NULL,
  PRIMARY KEY (`bigtextID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `dataResourceBigtext`
--


-- --------------------------------------------------------

--
-- Table structure for table `dataResourceType`
--

CREATE TABLE IF NOT EXISTS `dataResourceType` (
  `dataResourceTypeID` varchar(32) NOT NULL,
  `parentDataResourceTypeID` varchar(32) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(90) NOT NULL,
  `tableName` varchar(90) DEFAULT NULL,
  `tableIDColumn` varchar(32) NOT NULL,
  `tableContentColumn` varchar(32) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  PRIMARY KEY (`dataResourceTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `dataResourceType`
--

INSERT INTO `dataResourceType` (`dataResourceTypeID`, `parentDataResourceTypeID`, `name`, `description`, `tableName`, `tableIDColumn`, `tableContentColumn`, `dateCreated`, `dateLastModified`) VALUES
('BIGTEXT', NULL, 'Bigtext', 'Text greater than 255 words containing possibly mixed text/html', 'dataResourceBigtext', 'bigtextID', 'bigtext', '2010-06-14 13:41:54', '2010-06-14 13:41:54');

-- --------------------------------------------------------

--
-- Table structure for table `domain`
--

CREATE TABLE IF NOT EXISTS `domain` (
  `domainID` int(11) NOT NULL,
  `parentDomainID` int(11) DEFAULT NULL,
  `domainName` varchar(90) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  PRIMARY KEY (`domainID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `domain`
--

INSERT INTO `domain` (`domainID`, `parentDomainID`, `domainName`, `dateCreated`, `dateLastModified`) VALUES
(0, NULL, 'integratedweb.com.au', '2010-06-14 15:51:39', '2010-06-14 15:51:39');

-- --------------------------------------------------------

--
-- Table structure for table `domainAttribute`
--

CREATE TABLE IF NOT EXISTS `domainAttribute` (
  `domainID` int(11) NOT NULL,
  `attrTypeID` varchar(32) NOT NULL,
  `attrValue` varchar(90) NOT NULL,
  `dateAttrFrom` datetime NOT NULL,
  `dateAttrThru` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  KEY `DOMAIN` (`domainID`),
  KEY `ATTRIBUTE TYPE` (`attrTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `domainAttribute`
--


-- --------------------------------------------------------

--
-- Table structure for table `domainAttributeType`
--

CREATE TABLE IF NOT EXISTS `domainAttributeType` (
  `attrTypeID` varchar(32) NOT NULL,
  `attrParentTypeID` varchar(32) DEFAULT NULL,
  `attrName` varchar(45) NOT NULL,
  `attrDescription` varchar(90) DEFAULT NULL,
  `attrExample` varchar(45) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  PRIMARY KEY (`attrTypeID`),
  KEY `PARENT` (`attrParentTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `domainAttributeType`
--


-- --------------------------------------------------------

--
-- Table structure for table `domainEmailAlias`
--

CREATE TABLE IF NOT EXISTS `domainEmailAlias` (
  `domainEmailAliasID` int(11) NOT NULL AUTO_INCREMENT,
  `domainID` int(11) NOT NULL,
  `emailAliasID` int(11) NOT NULL,
  `dateFrom` datetime NOT NULL,
  `dateThru` datetime DEFAULT NULL,
  PRIMARY KEY (`domainEmailAliasID`),
  KEY `DOMAIN` (`domainID`),
  KEY `EMAIL ALIAS` (`emailAliasID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `domainEmailAlias`
--

INSERT INTO `domainEmailAlias` (`domainEmailAliasID`, `domainID`, `emailAliasID`, `dateFrom`, `dateThru`) VALUES
(1, 0, 1, '2010-06-14 15:51:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `emailAccount`
--

CREATE TABLE IF NOT EXISTS `emailAccount` (
  `emailAccountID` int(11) NOT NULL AUTO_INCREMENT,
  `username` varchar(32) NOT NULL,
  `password` varchar(64) NOT NULL,
  `serverIncoming` varchar(90) NOT NULL,
  `serverOutgoing` varchar(90) NOT NULL,
  PRIMARY KEY (`emailAccountID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `emailAccount`
--

INSERT INTO `emailAccount` (`emailAccountID`, `username`, `password`, `serverIncoming`, `serverOutgoing`) VALUES
(1, 'callan.milne', 'unknown', 'mail.integratedweb.com.au', 'mail.integratedweb.com.au');

-- --------------------------------------------------------

--
-- Table structure for table `emailAccountAttribute`
--

CREATE TABLE IF NOT EXISTS `emailAccountAttribute` (
  `emailAccountID` int(11) NOT NULL,
  `attrTypeID` varchar(32) NOT NULL,
  `attrValue` varchar(90) NOT NULL,
  `dateAttrFrom` datetime NOT NULL,
  `dateAttrThru` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  KEY `ACCOUNT` (`emailAccountID`),
  KEY `ATTRIBUTE TYPE` (`attrTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `emailAccountAttribute`
--


-- --------------------------------------------------------

--
-- Table structure for table `emailAccountAttributeType`
--

CREATE TABLE IF NOT EXISTS `emailAccountAttributeType` (
  `attrTypeID` varchar(32) NOT NULL,
  `attrParentTypeID` varchar(32) DEFAULT NULL,
  `attrName` varchar(45) NOT NULL,
  `attrDescription` varchar(90) DEFAULT NULL,
  `attrExample` varchar(45) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  PRIMARY KEY (`attrTypeID`),
  KEY `PARENT` (`attrParentTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `emailAccountAttributeType`
--


-- --------------------------------------------------------

--
-- Table structure for table `emailAlias`
--

CREATE TABLE IF NOT EXISTS `emailAlias` (
  `emailAliasID` int(11) NOT NULL AUTO_INCREMENT,
  `domainID` int(11) NOT NULL,
  `emailAlias` varchar(90) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  PRIMARY KEY (`emailAliasID`),
  KEY `domainID` (`domainID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `emailAlias`
--

INSERT INTO `emailAlias` (`emailAliasID`, `domainID`, `emailAlias`, `dateCreated`, `dateLastModified`) VALUES
(1, 0, 'callan.milne', '2010-06-14 15:51:39', '2010-06-14 15:51:39');

-- --------------------------------------------------------

--
-- Table structure for table `emailAliasAccount`
--

CREATE TABLE IF NOT EXISTS `emailAliasAccount` (
  `emailAliasAccountID` int(11) NOT NULL AUTO_INCREMENT,
  `emailAliasID` int(11) NOT NULL,
  `emailAccountID` int(11) NOT NULL,
  `dateFrom` datetime NOT NULL,
  `dateThru` datetime DEFAULT NULL,
  PRIMARY KEY (`emailAliasAccountID`),
  KEY `ALIAS` (`emailAliasID`),
  KEY `ACCOUNT` (`emailAccountID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `emailAliasAccount`
--

INSERT INTO `emailAliasAccount` (`emailAliasAccountID`, `emailAliasID`, `emailAccountID`, `dateFrom`, `dateThru`) VALUES
(1, 1, 1, '2010-06-14 15:51:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `invoice`
--

CREATE TABLE IF NOT EXISTS `invoice` (
  `invoiceID` int(11) NOT NULL AUTO_INCREMENT,
  `invoiceStatus` varchar(16) NOT NULL,
  `dateInvoiceCreated` datetime NOT NULL,
  `dateInvoiceSent` datetime DEFAULT NULL,
  `dateInvoiceDue` datetime NOT NULL,
  `dateInvoicePaid` datetime DEFAULT NULL,
  PRIMARY KEY (`invoiceID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `invoice`
--

INSERT INTO `invoice` (`invoiceID`, `invoiceStatus`, `dateInvoiceCreated`, `dateInvoiceSent`, `dateInvoiceDue`, `dateInvoicePaid`) VALUES
(1, 'PENDING', '2010-06-14 15:51:39', '2010-06-14 15:51:39', '2010-07-14 15:51:39', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `invoiceItem`
--

CREATE TABLE IF NOT EXISTS `invoiceItem` (
  `invoiceItemID` int(11) NOT NULL AUTO_INCREMENT,
  `invoiceID` int(11) NOT NULL,
  `parentInvoiceItemID` int(11) DEFAULT NULL,
  `itemSequence` int(11) DEFAULT NULL,
  `productID` int(11) DEFAULT NULL,
  `serviceID` int(11) DEFAULT NULL,
  `chargeType` varchar(16) NOT NULL,
  `itemDescription` varchar(90) NOT NULL,
  `itemQuantity` decimal(11,2) NOT NULL,
  `itemPrice` decimal(11,2) NOT NULL,
  `itemTaxable` tinyint(1) NOT NULL,
  PRIMARY KEY (`invoiceItemID`),
  KEY `INVOICE` (`invoiceID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `invoiceItem`
--

INSERT INTO `invoiceItem` (`invoiceItemID`, `invoiceID`, `parentInvoiceItemID`, `itemSequence`, `productID`, `serviceID`, `chargeType`, `itemDescription`, `itemQuantity`, `itemPrice`, `itemTaxable`) VALUES
(1, 1, NULL, 1, NULL, NULL, 'SERVICE', 'Design services provided (hourly)', 50.00, 45.00, 1),
(2, 1, 1, NULL, NULL, NULL, 'TAX', 'GST (10%)', 50.00, 4.50, 0),
(3, 1, NULL, 2, NULL, NULL, 'PRODUCT', 'Web hosting (advanced package) 12 months', 1.00, 750.00, 1),
(4, 1, 3, NULL, NULL, NULL, 'TAX', 'GST (10%)', 1.00, 75.00, 0);

-- --------------------------------------------------------

--
-- Table structure for table `session`
--

CREATE TABLE IF NOT EXISTS `session` (
  `sessionID` int(11) NOT NULL AUTO_INCREMENT,
  `cgiSessionID` varchar(64) NOT NULL,
  `dateFirstActivity` datetime NOT NULL,
  `dateLastActivity` datetime DEFAULT NULL,
  PRIMARY KEY (`sessionID`),
  UNIQUE KEY `CGI SESSION` (`cgiSessionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 COMMENT='Analytical session table' AUTO_INCREMENT=1 ;

--
-- Dumping data for table `session`
--


-- --------------------------------------------------------

--
-- Table structure for table `sessionActivity`
--

CREATE TABLE IF NOT EXISTS `sessionActivity` (
  `sessionID` int(11) NOT NULL,
  `sessionHTTPID` int(11) NOT NULL,
  `sessionRemoteID` int(11) NOT NULL,
  `sessionRequestID` int(11) NOT NULL,
  `sessionServerID` int(11) NOT NULL,
  `sequence` int(11) NOT NULL,
  `dateActivityLogged` datetime NOT NULL,
  KEY `SESSION HTTP` (`sessionHTTPID`),
  KEY `SESSION REMOTE` (`sessionRemoteID`),
  KEY `SESSION REQUEST` (`sessionRequestID`),
  KEY `SESSION SERVER` (`sessionServerID`),
  KEY `SESSION` (`sessionID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `sessionActivity`
--


-- --------------------------------------------------------

--
-- Table structure for table `sessionHTTP`
--

CREATE TABLE IF NOT EXISTS `sessionHTTP` (
  `sessionHTTPID` int(11) NOT NULL AUTO_INCREMENT,
  `httpAccept` varchar(45) NOT NULL,
  `httpCookie` varchar(45) NOT NULL,
  `httpHost` varchar(45) NOT NULL,
  `httpReferer` varchar(45) NOT NULL,
  `httpUserAgent` varchar(45) NOT NULL,
  `httpResponse` varchar(45) NOT NULL,
  PRIMARY KEY (`sessionHTTPID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `sessionHTTP`
--


-- --------------------------------------------------------

--
-- Table structure for table `sessionLog`
--

CREATE TABLE IF NOT EXISTS `sessionLog` (
  `sessionLogID` int(11) NOT NULL AUTO_INCREMENT,
  `cgiSessionID` varchar(64) NOT NULL,
  `contactID` int(11) DEFAULT NULL,
  `httpAccept` varchar(64) DEFAULT NULL,
  `httpCookie` varchar(64) DEFAULT NULL,
  `httpHost` varchar(64) DEFAULT NULL,
  `httpReferer` varchar(64) DEFAULT NULL,
  `httpUserAgent` varchar(64) DEFAULT NULL,
  `httpResponse` varchar(45) DEFAULT NULL,
  `remoteAddr` varchar(64) DEFAULT NULL,
  `remotePort` varchar(64) DEFAULT NULL,
  `requestMethod` varchar(64) DEFAULT NULL,
  `requestURI` varchar(255) DEFAULT NULL,
  `serverAddress` varchar(64) DEFAULT NULL,
  `serverName` varchar(64) DEFAULT NULL,
  `serverPort` varchar(64) DEFAULT NULL,
  `serverProtocol` varchar(64) DEFAULT NULL,
  `dateLogged` datetime NOT NULL,
  `dateEntered` datetime DEFAULT NULL,
  PRIMARY KEY (`sessionLogID`),
  KEY `CGI SESSION` (`cgiSessionID`),
  KEY `contactID` (`contactID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 COMMENT='Initial logging table all website logs are stored to before ' AUTO_INCREMENT=187 ;

--
-- Dumping data for table `sessionLog`
--

INSERT INTO `sessionLog` (`sessionLogID`, `cgiSessionID`, `contactID`, `httpAccept`, `httpCookie`, `httpHost`, `httpReferer`, `httpUserAgent`, `httpResponse`, `remoteAddr`, `remotePort`, `requestMethod`, `requestURI`, `serverAddress`, `serverName`, `serverPort`, `serverProtocol`, `dateLogged`, `dateEntered`) VALUES
(1, '08c258c28056b9598185b9aca7ec1b5b', NULL, '', '', '', '', '', '', '', '', '', '', '', '', '', '', '2010-06-17 20:06:01', NULL),
(2, '08c258c28056b9598185b9aca7ec1b5b', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=08c258c28056b9598185b9aca7ec1b5b', '', '', '', '', '', '', '', '', '', '', '', '', '2010-06-17 20:06:30', NULL),
(3, '08c258c28056b9598185b9aca7ec1b5b', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=08c258c28056b9598185b9aca7ec1b5b', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/hosting', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '46778', 'GET', '/hosting/reseller', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 20:08:17', NULL),
(4, '08c258c28056b9598185b9aca7ec1b5b', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=08c258c28056b9598185b9aca7ec1b5b', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/hosting/reseller', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '46787', 'GET', '/my-account/invoices', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 20:10:48', NULL),
(5, '08c258c28056b9598185b9aca7ec1b5b', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=08c258c28056b9598185b9aca7ec1b5b', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/invoices', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '57201', 'GET', '/my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 21:41:18', NULL),
(6, '08c258c28056b9598185b9aca7ec1b5b', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=08c258c28056b9598185b9aca7ec1b5b', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/invoices', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '57202', 'GET', '/my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 21:41:20', NULL),
(7, '08c258c28056b9598185b9aca7ec1b5b', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=08c258c28056b9598185b9aca7ec1b5b', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '38526', 'GET', '/my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 21:47:06', NULL),
(8, '08c258c28056b9598185b9aca7ec1b5b', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=08c258c28056b9598185b9aca7ec1b5b', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '38526', 'GET', '/my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 21:47:12', NULL),
(9, '08c258c28056b9598185b9aca7ec1b5b', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=08c258c28056b9598185b9aca7ec1b5b', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '38526', 'GET', '/my-account/details', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 21:47:16', NULL),
(10, '08c258c28056b9598185b9aca7ec1b5b', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=08c258c28056b9598185b9aca7ec1b5b', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/details', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '38526', 'GET', '/my-account/logout', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 21:47:21', NULL),
(11, '08c258c28056b9598185b9aca7ec1b5b', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=08c258c28056b9598185b9aca7ec1b5b', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/details', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '53112', 'GET', '/my-account/logout', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 21:50:32', NULL),
(12, '0372ddb4c3cdf7b4acf13b87c9dba44c', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=08c258c28056b9598185b9aca7ec1b5b', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '53112', 'GET', '/', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 21:50:37', NULL),
(13, '0372ddb4c3cdf7b4acf13b87c9dba44c', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=0372ddb4c3cdf7b4acf13b87c9dba44c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '53112', 'GET', '/my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 21:50:40', NULL),
(14, '0372ddb4c3cdf7b4acf13b87c9dba44c', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=0372ddb4c3cdf7b4acf13b87c9dba44c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '53112', 'GET', '/my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 21:50:45', NULL),
(15, '0372ddb4c3cdf7b4acf13b87c9dba44c', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=0372ddb4c3cdf7b4acf13b87c9dba44c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '53126', 'POST', '/my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 21:51:16', NULL),
(16, '0372ddb4c3cdf7b4acf13b87c9dba44c', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=0372ddb4c3cdf7b4acf13b87c9dba44c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '36793', 'GET', '', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 21:58:29', NULL),
(17, '0372ddb4c3cdf7b4acf13b87c9dba44c', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=0372ddb4c3cdf7b4acf13b87c9dba44c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '36793', 'GET', 'req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 21:58:33', NULL),
(18, '0372ddb4c3cdf7b4acf13b87c9dba44c', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=0372ddb4c3cdf7b4acf13b87c9dba44c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '35641', 'GET', 'req=my-account/logout', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 21:59:22', NULL),
(20, '0eab706e2412dbdd8bd48c6a9a2c4985', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=0372ddb4c3cdf7b4acf13b87c9dba44c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '35651', 'GET', '', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 22:00:58', NULL),
(21, '0eab706e2412dbdd8bd48c6a9a2c4985', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=0eab706e2412dbdd8bd48c6a9a2c4985', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '35652', 'POST', 'req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 22:01:13', NULL),
(22, '0eab706e2412dbdd8bd48c6a9a2c4985', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=0eab706e2412dbdd8bd48c6a9a2c4985', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '35663', 'GET', '', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 22:03:49', NULL),
(23, '0eab706e2412dbdd8bd48c6a9a2c4985', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=0eab706e2412dbdd8bd48c6a9a2c4985', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '59327', 'GET', 'req=my-account/logout;', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 22:08:49', NULL),
(24, '24b7105624ababd2e4c42838f8b4be43', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=0eab706e2412dbdd8bd48c6a9a2c4985', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '59327', 'GET', 'req=my-account;', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 22:08:57', NULL),
(25, '24b7105624ababd2e4c42838f8b4be43', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=24b7105624ababd2e4c42838f8b4be43', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '59327', 'POST', 'req=my-account/login;74', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 22:09:06', NULL),
(26, '24b7105624ababd2e4c42838f8b4be43', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=24b7105624ababd2e4c42838f8b4be43', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '37212', 'GET', 'req=my-account/logout;', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 22:11:22', NULL),
(27, 'c2bbf6018fd2bff6fec38ad8e88984c5', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=24b7105624ababd2e4c42838f8b4be43', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '37212', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 22:11:25', NULL),
(28, 'c2bbf6018fd2bff6fec38ad8e88984c5', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=c2bbf6018fd2bff6fec38ad8e88984c5', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '37212', 'POST', 'req=my-account/login;', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 22:11:32', NULL),
(29, 'c2bbf6018fd2bff6fec38ad8e88984c5', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=c2bbf6018fd2bff6fec38ad8e88984c5', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '38981', 'GET', 'req=my-account/logout;', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 22:14:23', NULL),
(30, 'a6c0e56738e97eb21b5f30a7341665a5', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=c2bbf6018fd2bff6fec38ad8e88984c5', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '38983', 'GET', 'req=my-account;', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 22:14:27', NULL),
(31, 'a6c0e56738e97eb21b5f30a7341665a5', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=a6c0e56738e97eb21b5f30a7341665a5', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '38983', 'POST', 'req=my-account/login;', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 22:14:34', NULL),
(32, 'a6c0e56738e97eb21b5f30a7341665a5', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=a6c0e56738e97eb21b5f30a7341665a5', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '39034', 'GET', 'req=my-account/logout;', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 22:18:19', NULL),
(33, '5f843abac2332c20d3ef875f8206cbaa', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=a6c0e56738e97eb21b5f30a7341665a5', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '39034', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 22:18:21', NULL),
(34, '5f843abac2332c20d3ef875f8206cbaa', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=5f843abac2332c20d3ef875f8206cbaa', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '39034', 'POST', 'req=my-account/login;', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 22:18:30', NULL),
(35, '5f843abac2332c20d3ef875f8206cbaa', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=5f843abac2332c20d3ef875f8206cbaa', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '56391', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 22:20:31', NULL),
(36, '5f843abac2332c20d3ef875f8206cbaa', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=5f843abac2332c20d3ef875f8206cbaa', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '56400', 'GET', 'req=about-us;', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-17 22:21:08', NULL),
(37, '0dc43df7a509f5b301adf81126849048', NULL, 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8', 'CGISESSID=3ad596fe16cec93ab04194e2833f0926', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.3) Gecko/2010', '', '127.0.0.1', '44026', 'GET', 'req=my-account/login;', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-18 12:59:20', NULL),
(38, '0dc43df7a509f5b301adf81126849048', NULL, 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8', 'CGISESSID=0dc43df7a509f5b301adf81126849048', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.3) Gecko/2010', '', '127.0.0.1', '44033', 'GET', 'req=my-account;', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-18 12:59:29', NULL),
(39, '0dc43df7a509f5b301adf81126849048', NULL, 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8', 'CGISESSID=0dc43df7a509f5b301adf81126849048', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.3) Gecko/2010', '', '127.0.0.1', '44031', 'GET', 'req=my-account/login;', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-18 12:59:31', NULL),
(40, '0dc43df7a509f5b301adf81126849048', NULL, 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8', 'CGISESSID=0dc43df7a509f5b301adf81126849048', 'eee-dev.integratedweb.com.au', '', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.3) Gecko/2010', '', '127.0.0.1', '44033', 'GET', 'req=my-account/websites;', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-18 12:59:44', NULL),
(41, '0dc43df7a509f5b301adf81126849048', NULL, 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8', 'CGISESSID=0dc43df7a509f5b301adf81126849048', 'eee-dev.integratedweb.com.au', '', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.3) Gecko/2010', '', '127.0.0.1', '44048', 'GET', 'req=my-account/my-websites;', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-18 12:59:55', NULL),
(42, '0dc43df7a509f5b301adf81126849048', NULL, 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8', 'CGISESSID=0dc43df7a509f5b301adf81126849048', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.3) Gecko/2010', '', '127.0.0.1', '52492', 'POST', 'req=my-account/login;;/my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-18 13:04:18', NULL),
(43, '0dc43df7a509f5b301adf81126849048', 1, 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8', 'CGISESSID=0dc43df7a509f5b301adf81126849048', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.3) Gecko/2010', '', '127.0.0.1', '52492', 'GET', ';;/', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-18 13:04:23', NULL),
(44, '0dc43df7a509f5b301adf81126849048', 1, 'text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8', 'CGISESSID=0dc43df7a509f5b301adf81126849048', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US; rv:1.9.2.3) Gecko/2010', '', '127.0.0.1', '52492', 'GET', 'req=services;;/services', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-18 13:04:28', NULL),
(45, '3059960e6c1fe9f97c4e4924012b370c', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', '', 'eee-dev.integratedweb.com.au', '', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '57668', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:06:30', NULL),
(46, '3059960e6c1fe9f97c4e4924012b370c', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=3059960e6c1fe9f97c4e4924012b370c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '57683', 'GET', 'req=services;req=services', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:06:36', NULL),
(47, '3059960e6c1fe9f97c4e4924012b370c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=3059960e6c1fe9f97c4e4924012b370c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/services', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '57684', 'POST', 'req=my-account/login;username=callan.milne&password=kazahak&req=my-account/login&submit=Login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:06:48', NULL),
(48, '3059960e6c1fe9f97c4e4924012b370c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=3059960e6c1fe9f97c4e4924012b370c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '57684', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:06:52', NULL),
(49, '3059960e6c1fe9f97c4e4924012b370c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=3059960e6c1fe9f97c4e4924012b370c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '57685', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:07:48', NULL),
(50, '3059960e6c1fe9f97c4e4924012b370c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=3059960e6c1fe9f97c4e4924012b370c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '43256', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:10:11', NULL),
(51, '3059960e6c1fe9f97c4e4924012b370c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=3059960e6c1fe9f97c4e4924012b370c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '43263', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:11:18', NULL),
(52, '3059960e6c1fe9f97c4e4924012b370c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=3059960e6c1fe9f97c4e4924012b370c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '43265', 'GET', 'req=my-account/invoices;req=my-account/invoices', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:11:26', NULL),
(53, '3059960e6c1fe9f97c4e4924012b370c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=3059960e6c1fe9f97c4e4924012b370c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/invoices', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '43265', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:11:33', NULL),
(54, '3059960e6c1fe9f97c4e4924012b370c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=3059960e6c1fe9f97c4e4924012b370c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '43265', 'GET', 'req=my-account/logout;req=my-account/logout', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:11:40', NULL),
(55, '690975eca1a6183242ab37dca045199c', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=3059960e6c1fe9f97c4e4924012b370c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '43265', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:11:44', NULL),
(56, '690975eca1a6183242ab37dca045199c', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '43614', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:14:00', NULL),
(57, '690975eca1a6183242ab37dca045199c', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '43619', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:14:07', NULL),
(58, '690975eca1a6183242ab37dca045199c', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '43618', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:14:09', NULL),
(59, '690975eca1a6183242ab37dca045199c', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '43624', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:15:26', NULL),
(60, '690975eca1a6183242ab37dca045199c', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '43625', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:15:52', NULL),
(61, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '43630', 'POST', 'req=my-account/login;username=callan.milne&password=kazahak&req=my-account/login&submit=Login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:16:04', NULL),
(62, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '43630', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:16:10', NULL),
(63, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '43630', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:16:15', NULL),
(64, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', '', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '43630', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:16:21', NULL),
(65, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', '', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '43633', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:17:23', NULL),
(66, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '35004', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:18:48', NULL),
(67, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '35005', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:20:10', NULL),
(68, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '35006', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:20:34', NULL),
(69, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '35007', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:21:33', NULL),
(70, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '35017', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:22:53', NULL),
(71, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '42225', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:24:33', NULL),
(72, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '42233', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:25:34', NULL),
(73, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '42234', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:25:46', NULL),
(74, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '42242', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:25:48', NULL),
(75, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '42244', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:26:20', NULL),
(76, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '42250', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:26:37', NULL),
(77, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '35020', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:30:02', NULL),
(78, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '35027', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:30:24', NULL),
(79, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '35034', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:30:44', NULL),
(80, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '35041', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:31:06', NULL),
(81, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '35046', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:31:16', NULL),
(82, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '35049', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:32:35', NULL),
(83, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '35054', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:32:45', NULL),
(84, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '35051', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:32:52', NULL),
(85, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '58533', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:34:21', NULL),
(86, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '58540', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:35:33', NULL),
(87, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '58547', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:35:57', NULL),
(88, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '58554', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:37:00', NULL),
(89, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '58559', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:37:14', NULL),
(90, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '58561', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:38:13', NULL),
(91, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '58566', 'GET', 'req=contact-us;req=contact-us', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:38:17', NULL),
(92, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '52552', 'GET', 'req=contact-us;req=contact-us', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:38:55', NULL),
(93, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '52559', 'GET', 'req=contact-us;req=contact-us', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:39:22', NULL),
(94, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '52566', 'GET', 'req=contact-us;req=contact-us', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:39:59', NULL),
(95, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '52566', 'GET', 'req=contact-us;req=contact-us', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:40:14', NULL),
(96, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '52576', 'GET', 'req=contact-us;req=contact-us', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:40:39', NULL),
(97, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '52596', 'GET', 'req=contact-us;req=contact-us', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:41:38', NULL),
(98, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '52603', 'GET', 'req=contact-us;req=contact-us', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:43:08', NULL),
(99, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '44038', 'GET', 'req=contact-us;req=contact-us', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:43:33', NULL),
(100, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '44043', 'GET', 'req=contact-us;req=contact-us', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:43:44', NULL),
(101, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '44045', 'GET', 'req=contact-us;req=contact-us', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:45:04', NULL),
(102, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '44052', 'GET', 'req=contact-us;req=contact-us', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:45:58', NULL),
(103, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '44058', 'GET', 'req=contact-us;req=contact-us', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:46:17', NULL),
(104, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '44063', 'GET', 'req=contact-us;req=contact-us', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:46:29', NULL),
(105, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '44065', 'GET', 'req=contact-us;req=contact-us', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:47:27', NULL),
(106, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '44072', 'GET', 'req=contact-us;req=contact-us', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:48:09', NULL),
(107, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '41095', 'GET', 'req=contact-us;req=contact-us', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:48:35', NULL),
(108, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '41095', 'GET', 'req=contact-us;req=contact-us', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:48:47', NULL),
(109, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/contact-us', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '41102', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:49:08', NULL),
(110, '690975eca1a6183242ab37dca045199c', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '52244', 'GET', 'req=my-account/logout;req=my-account/logout', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:56:34', NULL),
(111, '56faf89acfcfb52f261d6e1022a15a85', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '52244', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:56:38', NULL),
(112, '2cca26fc35ae68360c0a706a2d39253d', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=690975eca1a6183242ab37dca045199c', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', '', '127.0.0.1', '52245', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 14:56:40', NULL);
INSERT INTO `sessionLog` (`sessionLogID`, `cgiSessionID`, `contactID`, `httpAccept`, `httpCookie`, `httpHost`, `httpReferer`, `httpUserAgent`, `httpResponse`, `remoteAddr`, `remotePort`, `requestMethod`, `requestURI`, `serverAddress`, `serverName`, `serverPort`, `serverProtocol`, `dateLogged`, `dateEntered`) VALUES
(118, '2cca26fc35ae68360c0a706a2d39253d', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '36633', 'POST', 'req=my-account/login;username=''; SELECT * FROM customer;&password=Password ...&req=my-account/login&submit=Login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:18:16', NULL),
(119, '2cca26fc35ae68360c0a706a2d39253d', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '34732', 'POST', 'req=my-account/login;username='' SELECT * FROM table WHERE 1 ''&password=Password ...&req=my-account/login&submit=Login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:18:38', NULL),
(120, '2cca26fc35ae68360c0a706a2d39253d', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '34735', 'POST', 'req=my-account/login;username='' SELECT * FROM table WHERE 1 ''&password=Password ...&req=my-account/login&submit=Login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:22:31', NULL),
(121, '2cca26fc35ae68360c0a706a2d39253d', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54449', 'POST', 'req=my-account/login;username='' SELECT * FROM table WHERE 1 ''&password=Password ...&req=my-account/login&submit=Login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:23:50', NULL),
(122, '2cca26fc35ae68360c0a706a2d39253d', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54456', 'POST', 'req=my-account/login;username='' SELECT * FROM table WHERE 1 ''&password=Password ...&req=my-account/login&submit=Login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:24:39', NULL),
(123, '2cca26fc35ae68360c0a706a2d39253d', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54463', 'POST', 'req=my-account/login;username='' SELECT * FROM table WHERE 1 ''&password=Password ...&req=my-account/login&submit=Login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:25:44', NULL),
(124, '2cca26fc35ae68360c0a706a2d39253d', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54470', 'POST', 'req=my-account/login;username='' SELECT * FROM table WHERE 1 ''&password=Password ...&req=my-account/login&submit=Login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:26:06', NULL),
(126, '2cca26fc35ae68360c0a706a2d39253d', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54478', 'POST', 'req=my-account/login;username=callan.milne&password=kazahak&req=my-account/login&submit=Login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:27:07', NULL),
(127, '2cca26fc35ae68360c0a706a2d39253d', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54479', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:27:08', NULL),
(128, '2cca26fc35ae68360c0a706a2d39253d', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54480', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:27:10', NULL),
(129, '2cca26fc35ae68360c0a706a2d39253d', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54481', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:27:11', NULL),
(130, '2cca26fc35ae68360c0a706a2d39253d', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54482', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:27:13', NULL),
(131, '2cca26fc35ae68360c0a706a2d39253d', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54483', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:27:15', NULL),
(132, '2cca26fc35ae68360c0a706a2d39253d', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', NULL, 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54484', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:27:16', NULL),
(133, '2cca26fc35ae68360c0a706a2d39253d', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', NULL, 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54485', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:27:17', NULL),
(134, '2cca26fc35ae68360c0a706a2d39253d', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', NULL, 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54486', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:27:19', NULL),
(135, '2cca26fc35ae68360c0a706a2d39253d', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', NULL, 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54487', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:27:21', NULL),
(136, '2cca26fc35ae68360c0a706a2d39253d', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', NULL, 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54488', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:27:23', NULL),
(137, '2cca26fc35ae68360c0a706a2d39253d', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', NULL, 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54489', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:27:25', NULL),
(138, '2cca26fc35ae68360c0a706a2d39253d', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', NULL, 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54490', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:27:28', NULL),
(139, '2cca26fc35ae68360c0a706a2d39253d', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', NULL, 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54491', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:27:30', NULL),
(140, '2cca26fc35ae68360c0a706a2d39253d', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', NULL, 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54492', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:27:32', NULL),
(141, '2cca26fc35ae68360c0a706a2d39253d', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=2cca26fc35ae68360c0a706a2d39253d', 'eee-dev.integratedweb.com.au', NULL, 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54493', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:27:34', NULL),
(142, '42cfafb030bfe532394ccef4405fe4ab', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', NULL, 'eee-dev.integratedweb.com.au', NULL, 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54494', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:27:36', NULL),
(143, '42cfafb030bfe532394ccef4405fe4ab', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=42cfafb030bfe532394ccef4405fe4ab', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54494', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:27:42', NULL),
(144, '42cfafb030bfe532394ccef4405fe4ab', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=42cfafb030bfe532394ccef4405fe4ab', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54494', 'POST', 'req=my-account/login;username=callan.milne&password=kazahak&req=my-account/login&submit=Login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:27:48', NULL),
(145, '42cfafb030bfe532394ccef4405fe4ab', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=42cfafb030bfe532394ccef4405fe4ab', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '54494', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:27:55', NULL),
(146, '42cfafb030bfe532394ccef4405fe4ab', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=42cfafb030bfe532394ccef4405fe4ab', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '40441', 'GET', 'req=my-account/logout;req=my-account/logout', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:33:42', NULL),
(147, 'd09fbb910992e1f2c033fd74fa772cbb', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=42cfafb030bfe532394ccef4405fe4ab', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '40442', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:34:03', NULL),
(148, 'd09fbb910992e1f2c033fd74fa772cbb', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=d09fbb910992e1f2c033fd74fa772cbb', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '40442', 'POST', 'req=my-account/login;username=callan.milne&password=kazahak&req=my-account/login&submit=Login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:34:13', NULL),
(149, 'd09fbb910992e1f2c033fd74fa772cbb', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=d09fbb910992e1f2c033fd74fa772cbb', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '40443', 'GET', 'req=my-account/logout;req=my-account/logout', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:35:46', NULL),
(150, '4eed32e6457852717a91079976bf9bda', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=d09fbb910992e1f2c033fd74fa772cbb', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '40443', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:35:50', NULL),
(151, '4eed32e6457852717a91079976bf9bda', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=4eed32e6457852717a91079976bf9bda', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '40444', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:36:23', NULL),
(152, '4eed32e6457852717a91079976bf9bda', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=4eed32e6457852717a91079976bf9bda', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '40451', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:36:42', NULL),
(153, '4eed32e6457852717a91079976bf9bda', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=4eed32e6457852717a91079976bf9bda', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '40455', 'GET', 'req=my-account/logout;req=my-account/logout', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:36:59', NULL),
(154, '540e81b9f6f4703afea886b77ff2c029', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=4eed32e6457852717a91079976bf9bda', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '55755', 'POST', 'req=my-account/login;username=callan.milne&password=kazahak&req=my-account/login&submit=Login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:40:05', NULL),
(155, '8750c022e8c4504c2ee632a6fce3f776', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=540e81b9f6f4703afea886b77ff2c029', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '55755', 'GET', 'req=my-account/logout;req=my-account/logout', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:40:09', NULL),
(156, '8750c022e8c4504c2ee632a6fce3f776', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=8750c022e8c4504c2ee632a6fce3f776', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '55764', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:40:32', NULL),
(157, '8750c022e8c4504c2ee632a6fce3f776', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=8750c022e8c4504c2ee632a6fce3f776', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '55767', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:41:25', NULL),
(158, '8750c022e8c4504c2ee632a6fce3f776', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=8750c022e8c4504c2ee632a6fce3f776', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '55768', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:41:38', NULL),
(159, '8750c022e8c4504c2ee632a6fce3f776', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=8750c022e8c4504c2ee632a6fce3f776', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '55774', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:41:47', NULL),
(160, '8750c022e8c4504c2ee632a6fce3f776', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=8750c022e8c4504c2ee632a6fce3f776', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '55774', 'POST', 'req=my-account/login;username=callan.milne&password=kazahak&req=my-account/login&submit=Login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:41:53', NULL),
(161, 'f8fa913f9f9b30f9c4757861350ceddf', NULL, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=8750c022e8c4504c2ee632a6fce3f776', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/login', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48521', 'GET', 'req=my-account/logout;req=my-account/logout', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:43:37', NULL),
(162, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48521', 'POST', 'req=my-account/login;username=callan.milne&password=kazahak&req=my-account/login&submit=Login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:43:42', NULL),
(163, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48522', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:43:44', NULL),
(164, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48523', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:43:46', NULL),
(165, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48524', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:43:47', NULL),
(166, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48525', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:43:49', NULL),
(167, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48526', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:43:51', NULL),
(168, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48527', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:43:52', NULL),
(169, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48528', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:43:54', NULL),
(170, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48529', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:43:56', NULL),
(171, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48530', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:43:58', NULL),
(172, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48531', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:44:00', NULL),
(173, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48532', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:44:01', NULL),
(174, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48533', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:44:03', NULL),
(175, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48534', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:44:05', NULL),
(176, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48535', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:44:06', NULL),
(177, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48538', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:44:09', NULL),
(178, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48539', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:44:12', NULL),
(179, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48540', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:44:14', NULL),
(180, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48541', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:44:17', NULL),
(181, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48542', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:44:20', NULL),
(182, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account/logout', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48543', 'GET', 'req=my-account/login;req=my-account/login', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:44:23', NULL),
(183, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', NULL, 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48545', 'GET', 'req=my-account;req=my-account', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:45:38', NULL),
(184, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48550', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:46:12', NULL),
(185, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48550', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:46:27', NULL),
(186, 'f8fa913f9f9b30f9c4757861350ceddf', 1, 'application/xml,application/xhtml+xml,text/html;q=0.9,text/plain', 'CGISESSID=f8fa913f9f9b30f9c4757861350ceddf', 'eee-dev.integratedweb.com.au', 'http://eee-dev.integratedweb.com.au/my-account', 'Mozilla/5.0 (X11; U; Linux x86_64; en-US) AppleWebKit/533.4 (KHT', NULL, '127.0.0.1', '48553', 'GET', ';', '127.0.0.1', 'eee-dev.integratedweb.com.au', '80', 'HTTP/1.1', '2010-06-19 15:46:37', NULL);

-- --------------------------------------------------------

--
-- Table structure for table `sessionRemote`
--

CREATE TABLE IF NOT EXISTS `sessionRemote` (
  `sessionRemoteID` int(11) NOT NULL AUTO_INCREMENT,
  `remoteAddr` varchar(45) NOT NULL,
  `remotePort` varchar(45) NOT NULL,
  PRIMARY KEY (`sessionRemoteID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `sessionRemote`
--


-- --------------------------------------------------------

--
-- Table structure for table `sessionRequest`
--

CREATE TABLE IF NOT EXISTS `sessionRequest` (
  `sessionRequestID` int(11) NOT NULL AUTO_INCREMENT,
  `requestMethod` varchar(64) NOT NULL,
  `requestURI` varchar(255) NOT NULL,
  PRIMARY KEY (`sessionRequestID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `sessionRequest`
--


-- --------------------------------------------------------

--
-- Table structure for table `sessionServer`
--

CREATE TABLE IF NOT EXISTS `sessionServer` (
  `sessionServerID` int(11) NOT NULL AUTO_INCREMENT,
  `serverAddress` varchar(45) NOT NULL,
  `serverName` varchar(45) NOT NULL,
  `serverPort` varchar(45) NOT NULL,
  `serverProtocol` varchar(45) NOT NULL,
  PRIMARY KEY (`sessionServerID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `sessionServer`
--


-- --------------------------------------------------------

--
-- Table structure for table `ticket`
--

CREATE TABLE IF NOT EXISTS `ticket` (
  `ticketID` int(11) NOT NULL AUTO_INCREMENT,
  `parentTicketID` int(11) DEFAULT NULL,
  `contactID` int(11) NOT NULL,
  `websiteID` int(11) NOT NULL,
  `ticketCategoryID` int(11) NOT NULL,
  `ticketStatusID` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  PRIMARY KEY (`ticketID`),
  KEY `CONTACT` (`contactID`),
  KEY `TICKET CATEGORY` (`ticketCategoryID`),
  KEY `TICKET STATUS` (`ticketStatusID`),
  KEY `WEBSITE` (`websiteID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ticket`
--


-- --------------------------------------------------------

--
-- Table structure for table `ticketCategory`
--

CREATE TABLE IF NOT EXISTS `ticketCategory` (
  `ticketCategoryID` int(11) NOT NULL AUTO_INCREMENT,
  `parentTicketCategoryID` int(11) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(90) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  PRIMARY KEY (`ticketCategoryID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=5 ;

--
-- Dumping data for table `ticketCategory`
--

INSERT INTO `ticketCategory` (`ticketCategoryID`, `parentTicketCategoryID`, `name`, `description`, `dateCreated`, `dateLastModified`) VALUES
(1, NULL, 'Technical', 'Email, web and control panel issues', '2010-06-14 15:04:26', '2010-06-14 15:04:26'),
(2, NULL, 'Sales', 'New services, upgrades and quotes', '2010-06-14 15:04:26', '2010-06-14 15:04:26'),
(3, NULL, 'Billing / Accounts', 'Billing, invoices, payments and accounts', '2010-06-14 15:04:26', '2010-06-14 15:04:26'),
(4, NULL, 'Customer support', 'Support and help on general topics', '2010-06-14 15:04:26', '2010-06-14 15:04:26');

-- --------------------------------------------------------

--
-- Table structure for table `ticketPost`
--

CREATE TABLE IF NOT EXISTS `ticketPost` (
  `ticketPostID` int(11) NOT NULL AUTO_INCREMENT,
  `ticketID` int(11) NOT NULL,
  `contactID` int(11) NOT NULL,
  `dataResourceID` int(11) NOT NULL,
  `dateCreated` datetime NOT NULL,
  PRIMARY KEY (`ticketPostID`),
  KEY `CONTACT` (`contactID`),
  KEY `TICKET` (`ticketID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1 AUTO_INCREMENT=1 ;

--
-- Dumping data for table `ticketPost`
--


-- --------------------------------------------------------

--
-- Table structure for table `ticketStatus`
--

CREATE TABLE IF NOT EXISTS `ticketStatus` (
  `ticketStatusID` int(11) NOT NULL AUTO_INCREMENT,
  `parentTicketStatusID` int(11) DEFAULT NULL,
  `name` varchar(45) NOT NULL,
  `description` varchar(90) NOT NULL,
  `statusClass` varchar(45) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  PRIMARY KEY (`ticketStatusID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=8 ;

--
-- Dumping data for table `ticketStatus`
--

INSERT INTO `ticketStatus` (`ticketStatusID`, `parentTicketStatusID`, `name`, `description`, `statusClass`, `dateCreated`, `dateLastModified`) VALUES
(3, NULL, 'Pending', 'Ticket is pending initial response', NULL, '2010-06-14 15:04:26', '2010-06-14 15:04:26'),
(4, NULL, 'Waiting for customer', 'Ticket needs response or action by customer', NULL, '2010-06-14 15:04:26', '2010-06-14 15:04:26'),
(5, NULL, 'In progress', 'Ticket request is being processed', NULL, '2010-06-14 15:04:26', '2010-06-14 15:04:26'),
(6, NULL, 'Complete', 'Ticket request has been completed', NULL, '2010-06-14 15:04:26', '2010-06-14 15:04:26'),
(7, NULL, 'Closed/Cancelled', 'Ticket has been closed or cancelled', NULL, '2010-06-14 15:04:26', '2010-06-14 15:04:26');

-- --------------------------------------------------------

--
-- Table structure for table `website`
--

CREATE TABLE IF NOT EXISTS `website` (
  `websiteID` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) NOT NULL,
  `primaryURL` varchar(45) NOT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  PRIMARY KEY (`websiteID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `website`
--

INSERT INTO `website` (`websiteID`, `name`, `primaryURL`, `dateCreated`, `dateLastModified`) VALUES
(1, 'Integrated Web Services', 'http://www.integratedweb.com.au', '2010-06-14 15:51:39', '2010-06-14 15:51:39');

-- --------------------------------------------------------

--
-- Table structure for table `websiteAttribute`
--

CREATE TABLE IF NOT EXISTS `websiteAttribute` (
  `websiteID` int(11) NOT NULL,
  `attrTypeID` varchar(32) NOT NULL,
  `attrValue` varchar(90) NOT NULL,
  `dateAttrFrom` datetime NOT NULL,
  `dateAttrThru` datetime DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  KEY `WEBSITE` (`websiteID`),
  KEY `WEBSITE ATTRIBUTE` (`attrTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `websiteAttribute`
--


-- --------------------------------------------------------

--
-- Table structure for table `websiteAttributeType`
--

CREATE TABLE IF NOT EXISTS `websiteAttributeType` (
  `attrTypeID` varchar(32) NOT NULL,
  `attrParentTypeID` varchar(32) DEFAULT NULL,
  `attrName` varchar(45) NOT NULL,
  `attrDescription` varchar(90) DEFAULT NULL,
  `attrExample` varchar(45) DEFAULT NULL,
  `dateCreated` datetime NOT NULL,
  `dateLastModified` datetime NOT NULL,
  PRIMARY KEY (`attrTypeID`)
) ENGINE=InnoDB DEFAULT CHARSET=latin1;

--
-- Dumping data for table `websiteAttributeType`
--


-- --------------------------------------------------------

--
-- Table structure for table `websiteDomain`
--

CREATE TABLE IF NOT EXISTS `websiteDomain` (
  `websiteDomainID` int(11) NOT NULL AUTO_INCREMENT,
  `websiteID` int(11) NOT NULL,
  `domainID` int(11) NOT NULL,
  `dateFrom` datetime NOT NULL,
  `dateThru` datetime DEFAULT NULL,
  PRIMARY KEY (`websiteDomainID`),
  KEY `WEBSITE` (`websiteID`),
  KEY `DOMAIN` (`domainID`)
) ENGINE=InnoDB  DEFAULT CHARSET=latin1 AUTO_INCREMENT=2 ;

--
-- Dumping data for table `websiteDomain`
--

INSERT INTO `websiteDomain` (`websiteDomainID`, `websiteID`, `domainID`, `dateFrom`, `dateThru`) VALUES
(1, 1, 0, '2010-06-14 15:51:39', NULL);

--
-- Constraints for dumped tables
--

--
-- Constraints for table `address`
--
ALTER TABLE `address`
  ADD CONSTRAINT `STATE` FOREIGN KEY (`stateID`) REFERENCES `dataCountryState` (`stateID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `companyAddress`
--
ALTER TABLE `companyAddress`
  ADD CONSTRAINT `companyAddress_ibfk_1` FOREIGN KEY (`companyID`) REFERENCES `company` (`companyID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `companyAddress_ibfk_2` FOREIGN KEY (`addressID`) REFERENCES `address` (`addressID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `contactAddress`
--
ALTER TABLE `contactAddress`
  ADD CONSTRAINT `contactAddress_ibfk_1` FOREIGN KEY (`contactID`) REFERENCES `contact` (`contactID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `contactAddress_ibfk_2` FOREIGN KEY (`addressID`) REFERENCES `address` (`addressID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `contactAttribute`
--
ALTER TABLE `contactAttribute`
  ADD CONSTRAINT `contactAttribute_ibfk_1` FOREIGN KEY (`attrTypeID`) REFERENCES `contactAttributeType` (`attrTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `contactAttribute_ibfk_2` FOREIGN KEY (`contactID`) REFERENCES `contact` (`contactID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `contactLogin`
--
ALTER TABLE `contactLogin`
  ADD CONSTRAINT `contactLogin_ibfk_1` FOREIGN KEY (`contactID`) REFERENCES `contact` (`contactID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `customer`
--
ALTER TABLE `customer`
  ADD CONSTRAINT `COMPANY` FOREIGN KEY (`companyID`) REFERENCES `company` (`companyID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `customerContact`
--
ALTER TABLE `customerContact`
  ADD CONSTRAINT `CONTACT` FOREIGN KEY (`contactID`) REFERENCES `contact` (`contactID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `CONTACT TYPE` FOREIGN KEY (`contactTypeID`) REFERENCES `contactType` (`contactTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `CUSTOMER` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `customerInvoice`
--
ALTER TABLE `customerInvoice`
  ADD CONSTRAINT `customerInvoice_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `customerInvoice_ibfk_2` FOREIGN KEY (`invoiceID`) REFERENCES `invoice` (`invoiceID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `customerWebsite`
--
ALTER TABLE `customerWebsite`
  ADD CONSTRAINT `customerWebsite_ibfk_1` FOREIGN KEY (`customerID`) REFERENCES `customer` (`customerID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `customerWebsite_ibfk_2` FOREIGN KEY (`websiteID`) REFERENCES `website` (`websiteID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `dataCountryState`
--
ALTER TABLE `dataCountryState`
  ADD CONSTRAINT `COUNTRY` FOREIGN KEY (`countryID`) REFERENCES `dataCountry` (`countryID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `dataResource`
--
ALTER TABLE `dataResource`
  ADD CONSTRAINT `dataResource_ibfk_1` FOREIGN KEY (`dataResourceTypeID`) REFERENCES `dataResourceType` (`dataResourceTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `domainAttribute`
--
ALTER TABLE `domainAttribute`
  ADD CONSTRAINT `domainAttribute_ibfk_1` FOREIGN KEY (`domainID`) REFERENCES `domain` (`domainID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `domainAttribute_ibfk_2` FOREIGN KEY (`attrTypeID`) REFERENCES `domainAttributeType` (`attrTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `domainEmailAlias`
--
ALTER TABLE `domainEmailAlias`
  ADD CONSTRAINT `domainEmailAlias_ibfk_1` FOREIGN KEY (`domainID`) REFERENCES `domain` (`domainID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `domainEmailAlias_ibfk_2` FOREIGN KEY (`emailAliasID`) REFERENCES `emailAlias` (`emailAliasID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `emailAccountAttribute`
--
ALTER TABLE `emailAccountAttribute`
  ADD CONSTRAINT `emailAccountAttribute_ibfk_1` FOREIGN KEY (`emailAccountID`) REFERENCES `emailAccount` (`emailAccountID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `emailAccountAttribute_ibfk_2` FOREIGN KEY (`attrTypeID`) REFERENCES `emailAccountAttributeType` (`attrTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `emailAlias`
--
ALTER TABLE `emailAlias`
  ADD CONSTRAINT `emailAlias_ibfk_1` FOREIGN KEY (`domainID`) REFERENCES `domain` (`domainID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `emailAliasAccount`
--
ALTER TABLE `emailAliasAccount`
  ADD CONSTRAINT `emailAliasAccount_ibfk_1` FOREIGN KEY (`emailAliasID`) REFERENCES `emailAlias` (`emailAliasID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `emailAliasAccount_ibfk_2` FOREIGN KEY (`emailAccountID`) REFERENCES `emailAccount` (`emailAccountID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `invoiceItem`
--
ALTER TABLE `invoiceItem`
  ADD CONSTRAINT `invoiceItem_ibfk_1` FOREIGN KEY (`invoiceID`) REFERENCES `invoice` (`invoiceID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `sessionActivity`
--
ALTER TABLE `sessionActivity`
  ADD CONSTRAINT `sessionActivity_ibfk_1` FOREIGN KEY (`sessionHTTPID`) REFERENCES `sessionHTTP` (`sessionHTTPID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `sessionActivity_ibfk_2` FOREIGN KEY (`sessionRemoteID`) REFERENCES `sessionRemote` (`sessionRemoteID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `sessionActivity_ibfk_3` FOREIGN KEY (`sessionRequestID`) REFERENCES `sessionRequest` (`sessionRequestID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `sessionActivity_ibfk_4` FOREIGN KEY (`sessionServerID`) REFERENCES `sessionServer` (`sessionServerID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `sessionLog`
--
ALTER TABLE `sessionLog`
  ADD CONSTRAINT `sessionLog_ibfk_1` FOREIGN KEY (`contactID`) REFERENCES `contact` (`contactID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `websiteAttribute`
--
ALTER TABLE `websiteAttribute`
  ADD CONSTRAINT `websiteAttribute_ibfk_1` FOREIGN KEY (`websiteID`) REFERENCES `website` (`websiteID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `websiteAttribute_ibfk_2` FOREIGN KEY (`attrTypeID`) REFERENCES `websiteAttribute` (`attrTypeID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

--
-- Constraints for table `websiteDomain`
--
ALTER TABLE `websiteDomain`
  ADD CONSTRAINT `websiteDomain_ibfk_1` FOREIGN KEY (`websiteID`) REFERENCES `website` (`websiteID`) ON DELETE NO ACTION ON UPDATE NO ACTION,
  ADD CONSTRAINT `websiteDomain_ibfk_2` FOREIGN KEY (`domainID`) REFERENCES `domain` (`domainID`) ON DELETE NO ACTION ON UPDATE NO ACTION;

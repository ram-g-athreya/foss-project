

# Car Valuation API (PHP)

## Installation

To install the API download the PHP file provided in this repository and include it in a suitable folder within your project.

## Initialization

Create a CarValuationAPI Object by passing the Key & Secret as arguments. This object must be initialized before making any API Requests.

```php
require(‘CarValuationAPI.php’);
$api = new CarValuationAPI($key, $secret);
```

## Usage

Used Car Valuation is a 5 step process which consists of :


Car Location & Manufactured Date -> Manufacturer -> Model -> Variant -> Price

1. Getting Car Manufactured Month, Year & Location
2. Getting Manufacturer
3. Getting Model
4. Getting Variant
5. Getting Price

The Following sections detail about getting information required for processing each step

1. [Location Data](#location-data)
 
2. [Manufacturer Data](#manufacturer-data)

3. [Model Data](#model-data)

4. [Variant Data](#variant-data)

5. [Price Data](#price-data)

#### Location Data

List of available cities are provided through the following function

###### SYNTAX  

```php
$api->getCityData();
```

###### INPUT

```
No Input Required
```

###### OUTPUT
```php
[
    data => [
        city => city_name (STRING)
    ]
];
```

###### EXAMPLE

```php
//Get all cities
$api->getCityData();

//Server Output
[
    ‘data’ => [
        ‘775’ => ‘Adilabad’,
		‘776’ => ‘Chittoor’
		…
    ]
];
```

### Manufacturer Data

List of available manufacturers are provided for a given month and year using the following function

###### SYNTAX

```php
$api->getManufacturerData($month, $year);
```

###### INPUT

```php
* $month : INT 
  between 1 to 12

* $year : INT 
  any year within the last 20 years
```

###### OUTPUT

```php
[
	data => [
		manufacturer => manufacturer_name (STRING)
    ]
]
```

###### EXAMPLE

```php
//Get all manufacturers who had launched cars on or before May 2012
$api->getManufacturerData(5, 2012); 

//Server Output
[
	‘data’ => [
		‘101’ => ‘Aston Martin’,
		‘102’ => ‘Audi’
		...
    ]
]
```

### Model Data

List of available models are provided for a given month, year and manufacturer using the following function

###### SYNTAX

```php
$api->getModelData($month, $year, $manufacturer);
```

###### INPUT

```php
* $month : INT 
  between 1 to 12

* $year : INT 
  any year within the last 20 years
  
* $manufacturer : INT 
  Any valid manufacturer
```

###### OUTPUT

```php
[
	data => [
		model => model_name (STRING)
    ]
]
```

###### EXAMPLE

```php
//Get all models of Aston Martin which were launched on or before May 2012
$models = $api->getModelData(5, 2012, 101);

//Server Output
[
	‘data’ => [
		‘1001’ => ‘DB9’,
		‘1002’ => ‘DBS’
		...
    ]
]
```

### Variant Data

List of available variants are provided for a given month, year, manufacturer and model using the following function

###### SYNTAX

```
$api->getVariantData($month, $year, $model);
```

###### INPUT

```php
* $month : INT 
  between 1 to 12

* $year : INT 
  any year within the last 20 years

* $model : INT 
  Any valid model
```

###### OUTPUT

```php
[
	data => [
		variant => variant_name (STRING)
    ]
]
```

###### EXAMPLE

```php
//Get all variants of Aston Martin DB9 which were launched on or before May 2012
$variants = $api->getVariantData(5, 2012, 1001);

//Server Output
[
	‘data’ => 
		‘10029’ => ‘Coupe’,
		‘10031’ => ‘V12’
		...
    }
}
```

### Price Data

The price data API requires the following *mandatory* fields for calculating the price of a used car: 

* **Car Manufactured Month**
* **Car Manufactured Year**
* **Car Registered City**
* **Car Variant**
* **User Type**


Additionally it supports the following *optional* parameters:

* **Owner** : The owner type of the car. To get the list of available owner types use the function below :
```php
$api->getOwnerTypes();
```

* **Driver** : To get the list of available driver types use the function below :
```php
$api->getDriverTypes();
```

* **Accident** : If the car has undergone any accident. To get the list of available accident types use the function below :
```php
$api->getAccidentTypes();
```

* **Insurance** : The insurance policy that covers the car (expired if none is available).  To get the list of available insurance types use the function below :
```php
$api->getInsuranceTypes();
```

* **Insurance Expiry** : This parameter is **required only when Comprehensive or Third-Party Insurance** is chosen. The insurance expiry date must be **within 1 year of current date and cannot be a date of the past**

* **Color** : The color list is variant specific so it requires the variant as a parameter. To get the list of available colors for a given variant use the function below :
```php
$api->getColor($variant);
```

###### SYNTAX

```php
$api->getPriceData($month, $year, $city, $variant, $user_type, $options);
```

###### INPUT

```php
* $month : INT 
  between 1 to 12

* $year : INT 
  any year within the last 20 years
  
* $city : INT 
  any valid city
  
* $variant : INT 
  Any valid variant
  
* $user_type : STRING 
  Can be either ‘buyer’ or ‘seller’ in lower case

* $options : ARRAY
  optional
    * $odometer : INT
      between 1000 to 175000 Kms

    * $owner : INT
      Any valid owner type
    
    * $driver : INT
      Any valid driver
    
    * $color : STRING
      Any valid color for the given variant
    
    * $insurance : INT
      Any valid insurance
      
    * $insurance_expiry : DATE
      Format for date is 'yyyy-mm-dd'
```

###### OUTPUT

```php
[
	data => [
		excellent => [
			individual => individual_price (INT),
			dealer_price => dealer_price (INT)
        ],
		good => [
			individual => individual_price (INT),
			dealer_price => dealer_price (INT)
        ],
		fair => [
			individual => individual_price (INT),
			dealer_price => dealer_price (INT)
        ]
    ],
    price_checks_left => count (INT)
]
```

###### EXAMPLE

```php
//Get the selling price for Aston Martin DB9 manufactured in May 2012
$prices = $api->getPriceData(5, 2012, 775, 10029, 'seller');

//Server Output
[
	‘data’ => [
		‘excellent’ => [
			‘individual’ => 14798249,
			‘dealer’ => 14184278
        ],
        ‘good’ => [
	        ‘individual’ => 14295049,
			‘dealer’ => 13585308
        ],
        ‘fair => [
	        ‘individual’ => 13673449,
			‘dealer’ => 12856741
        ]
    ],
    'price_checks_left' => 499
]


//Get the selling price for Aston Martin DB9 manufactured in May 2012 that has run Comprehensive Insurance which expires on Jun 5 2015
$prices = $api->getPriceData(5, 2012, 775, 10029, 'seller', array(
    'insurance' => 3,
    'insurance_expiry' => '2015-06-05'
));

//Get the selling price for Aston Martin DB9 manufactured in May 2012 having the color Midnight Blue(#020A2E) and having a minor accident
$prices = $api->getPriceData(5, 2012, 775, 10029, 'seller', array(
    'accident' => 2,
    'color' => '020A2E'
));


```

## Missing Data

write up required - sometimes some data may be missing so this feature can be used to report what is missing

Following are possible scenarios of missing data :

1. [Missing Manufacturer](#missing-manufacturer)
 
2. [Missing Model](#missing-model)

3. [Missing Variant](#missing-variant)


### Missing Manufacturer

A particular manufacturer may not be available for a month year combination, in such a case report the missing data with the given month & year as arguments. 

###### SYNTAX

```php
//Returns all manufacturers who did not have cars available on or before given month and year
$manufacturers = $api->getOtherManufacturers($month, $year);

//If the Manufacturer is included in the $manufacturers list then provide it as a parameter otherwise it is optional
$api->reportMissingManufacturer($year, $month, $description, $manufacturer);
```

###### EXAMPLE

```php
//Manufacturers that did not have cars available on or before May 2014
$manufacturers = $api->getOtherManufacturers(5, 2014);

//Output
'data' => 
  146 => 'Bajaj'
  150 => 'Conquest'
  ...

//If the Manufacturer is in the list
$api->reportMissingManufacturer(5, 2014, 'Bajaj is not available', 146);

//If manufacturer is not in the list
$api->reportMissingManufacturer(5, 2014, 'Caterham is not available');
```

### Missing Model

A particular model may not be available for a month, year and manufacturer combination, in such a case report the missing data with the given month, year & manufacturer as arguments.

###### SYNTAX

```php
//Returns all models for a given month, year and manufacturer other than the ones sent in the getModelData() call
$models = $api->getOtherModels($month, $year, $manufacturer);

//If the Manufacturer is included in the $manufacturers list then provide it as a parameter otherwise it is optional
$api->reportMissingModel($year, $month, $description, $manufacturer, $model);
```

###### EXAMPLE

```php
//Manufacturers that did not have cars available on or before May 2014
$models = $api->getOtherModels(5, 2012, 101);

//Output
'data' => 
  1319 => 'V12 Vanquish'
  ...

//If the Model is in the list  
$api->reportMissingModel(5, 2012, 'V12 Vanquish not available', 101, 1319);

//If the Model is not in the list model need not be provided
$api->reportMissingModel(5, 2012, 'V14 Vanquish not available', 101);
```

### Missing Variant
A particular variant may not be available for a month, year, manufacturer & model combination, in such a case report the missing data with the given month, year, manufacturer & model as arguments

###### SYNTAX

```php
$api->reportMissingVariant($month, $year, $description, $manufacturer, $model);

```
###### EXAMPLE

To report a missing variant for example Maruti Suzuki Verna (in a given year) the following code can be used

```php
$api->reportMissingVariant(10, 2012, 'Missing Variant LXI for Verna', array(
    'manufacturer' => 125,
    'model' => 1135
));
```


### Support and Feedback

If you find a bug, please submit the issue in GitHub directly. For any other queries please drop us a note at [contact@rightcar.com](mailto:contact@rightcar.com?subject=Reg:CarValuation-PHP-API)

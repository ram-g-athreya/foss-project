Copy paste the contents of this file in https://stackedit.io/editor

# RightCar-PHP

## Installation

To install the API just download the PHP file provided in this repository and include it in a suitable folder within your project.

## Usage

The API contains the following functions for fetching data

**1. City Data**

**2. Manufacturer Data**

**3. Model Data**

**4. Variant Data**

**5. Price Data**

**6. Feedback**

**7. Missing Data**

#### Initialization
Initialize a RightCarApi Object before making any calls using the API.


Require the RightCarApi php file from the folder in your project and initialize a RightCarApi object by passing the Key & Secret as arguments.
```php
require(‘RightCarApi.php’);
$api = new RightCarApi($key, $secret);
```
#### City Data

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
{
    data => {
        city_id => city_name (STRING)
    }
};
```

###### EXAMPLE

```php
{
	‘data’ => {
		‘775’ => ‘Adilabad’,
		‘776’ => ‘Chittoor’
		…
    }
};
```

### Manufacturer Data

#### SYNTAX

```php
$api->getManufacturerData($month, $year);
```

#### INPUT

```php
$month : INT (between 1 to 12)
$year : INT (any year within the last 20 years)
```

#### OUTPUT

```php
{
	data => {
		manufacturer_id => manufacturer_name (STRING)
    }
}
```

#### EXAMPLE

```php
{
	‘data’ => {
		‘101’ => ‘Aston Martin’,
		‘102’ => ‘Audi’
		...
    }
}
```

### Model Data

#### SYNTAX

```php
$api->getModelData($month, $year, $manufacturer_id);
```

#### INPUT

```php
$month : INT (between 1 to 12)
$year : INT (any year within the last 20 years)
$manufacturer_id : INT (Any valid manufacturer id)
```

#### OUTPUT

```php
{
	data => {
		model_id => model_name (STRING)
    }
}
```

#### EXAMPLE

```php
{
	‘data’ => {
		‘1001’ => ‘DB9’,
		‘1002’ => ‘DBS’
		...
    }
}
```

### Variant Data

#### SYNTAX

```
$api->getVariantData($month, $year, $model_id);
```

#### INPUT

```php
$month : INT (between 1 to 12)
$year : INT (any year within the last 20 years)
$model_id : INT (Any valid model id)
```

#### OUTPUT

```php
{
	data => {
		variant_id => variant_name (STRING)
    }
}
```

#### EXAMPLE

```php
{
	‘data’ => {
		‘10029’ => ‘Coupe’,
		‘10031’ => ‘V12’
		...
    }
}
```

### Price Data

#### SYNTAX

```php
$api->getPriceData($month, $year, $city_id, $variant_id, $odometer, $user_type);
```

#### INPUT

```php
$month : INT (between 1 to 12)
$year : INT (any year within the last 20 years)
$city_id : INT (any valid city id)
$variant_id : INT (Any valid variant id)
$odometer : INT (between 1000 to 175000 Kms)
$user_type : STRING (Can be either ‘buyer’ or ‘seller’ in lower case)
```

#### OUTPUT

```php
{
	data => {
		excellent => {
			individual => individual_price (INT),
			dealer_price => dealer_price (INT)
        },
		good => {
			individual => individual_price (INT),
			dealer_price => dealer_price (INT)
        },
		fair => {
			individual => individual_price (INT),
			dealer_price => dealer_price (INT)
        }
    }
}
```

#### EXAMPLE

```php
{
	‘data’ => {
		‘excellent’ => {
			‘individual’ => 14798249,
			‘dealer’ => 14184278
        },
        ‘good’ => {
	        ‘individual’ => 14295049,
			‘dealer’ => 13585308
        },
        ‘fair => {
	        ‘individual’ => 13673449,
			‘dealer’ => 12856741
        }
    }
}
```

### Missing Data

#### SYNTAX
```php
$api->reportMissingData($month, $year, $description, $options);
```

#### INPUT

```php
* $month : INT
  between 1 to 12

* $year : INT
  any year within the last 20 years

* $description : STRING
  between 10 to 255 characters

* $options : ARRAY
  optional
    * $id_city : INT
      optional, if set must be a valid city id

    * $id_car_manufacturer : INT
      optional, if set must be a valid manufacturer id

    * $id_car_model : INT
      optional, if set must be a valid model id
```

#### EXAMPLE

To report a missing manufacturer such as San Motors the following code can be used. Please note that options are not included here since they are optional and are not required in this case.

```php
$api->reportMissingData(10, 2012, 'Missing Manufacturer San Motors');
```

To report a missing variant in Maruti Suzuki Verna (for a given year) the following code can be used. Please note that the city parameter is not included here since it is optional.

```php
$api->reportMissingData(10, 2012, 'Missing Variant LXI for Verna', array(
    'id_car_manufacturer' => 125,
    'id_car_model' => 1135
));
```


### Support and Feedback

If you find a bug, please submit the issue in GitHub directly. For any other queries please drop us a note at [contact@rightcar.com](mailto:contact@rightcar.com?subject=Reg:RightCar-PHP-API)

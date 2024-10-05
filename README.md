
# Util_GlobalValueSetUpdater - Salesforce Apex Utility

This Apex class, `Util_GlobalValueSetUpdater`, allows you to update Global Value Sets (GVS) in Salesforce via the Tooling API. You can add or modify values in an existing Global Value Set using the provided API name and a map of API names to their corresponding labels.

## Features

- Update the set with new or modified picklist values.
- Supports specifying API version (defaults to v61.0).

## Prerequisites

- Salesforce Developer Org or Sandbox with Tooling API enabled.
- Apex enabled and API access in your org.
- Basic understanding of Salesforce Global Value Sets.

## Installation

1. Clone the repository to your Salesforce project folder.

```bash
git clone https://github.com/vdev2x/global-value-set-updater.git
```

2. Deploy the classes `Util_GlobalValueSetUpdater`, `Util_GlobalValueSetUpdater_Wrapper` and `Util_GlobalValueSetUpdater_Test` to your Salesforce org using Salesforce DX or any deployment tool.

3. Ensure that Tooling API access is enabled in your Salesforce org.

## Usage

### Class Overview

The class provides two primary methods to update a Global Value Set:

```java
public static void updateGlobalValueSet(String developerName, Map<String, String> apiNameLabelMap)
public static void updateGlobalValueSet(String developerName, Map<String, String> apiNameLabelMap, String apiVersion)
```

- `developerName`: The API name of the Global Value Set you wish to update.
- `apiNameLabelMap`: A map where the key is the API name of the picklist value, and the value is the label.
- `apiVersion`: Optional. Specifies the version of the Tooling API (defaults to `v61.0`).

### Example Usage

```apex
// Create a map of API names and their corresponding labels
Map<String, String> apiNameLabelMap = new Map<String, String>{
    'VALUE_API_1' => 'Label 1',
    'VALUE_API_2' => 'Label 2'
};

// Update the Global Value Set named 'My_GlobalValueSet'
Util_GlobalValueSetUpdater.updateGlobalValueSet('My_GlobalValueSet', apiNameLabelMap);
```

This example demonstrates updating the Global Value Set `My_GlobalValueSet` by adding or modifying two picklist values.

### Error Handling

The class throws the following custom exceptions:
- `NoAccessException`: Thrown if the Tooling API request fails due to authorization issues.
- `NoDataFoundException`: Thrown if no Global Value Set is found with the specified `developerName`.
- `HandledException`: Thrown for other unexpected errors during the update process.

## Contributing

Feel free to submit issues or pull requests if you find bugs or have suggestions for improvements.

## License

This project is licensed under the MIT License - see the [LICENSE](LICENSE) file for details.

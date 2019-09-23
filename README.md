
## Periodic Table: Debugging Exercise

## Instructions
There are a number of issues with the project in this directory. There are crashes, errors, and features that do not work. These issues might occur in the Models, Views, Controllers, and networking aspects of the app. The git history will not help you, as the creator of this repository forgot to make meaningful commits as they created the app. They are sorry about that.

The objectives and details of the assignment are below.


## Debugging Hints

- Launch the app and see if it works
- Read the error messages
- Enter breakpoints in the lines before crashes, and before or after performing actions
- Read the error messages
- Test features to make sure they work in the way you (a user) would expect
- Read the error messages


## Objective

* Build a table view that loads and displays a list of the Elements, one per cell/row. Use a custom UITableViewCell subclass.  It should have 2 labels and one image.  The image should be pinned to the left of cell from the small images endpoint below.  The labels should be configured as below:

```
Name
Symbol(Number) Atomic Weight

e.g.

Sodium
Na(11) 22.989769282
```

Load a thumbnail image on each row as described below under Endpoints > Images.  For full credit, use a custom tableViewCell to make the image more readable.

* Tapping a cell segues to a detail view that:
* set the navigation bar title to the ```name``` of the element
* shows the larger image 
* and the following data:
* symbol
* number
* weight
* melting point
* boiling point
* discovery by

* has a button that, when pressed, selects this element as your favorite. This
should be implemented by a POST to the ```favorites``` endpoint. You will not need to update the UI for your `favorite`.


Try to format the detail view as much like an individual element on a traditional periodic table as you can. You **cannot** use the thumbnail image inside the detail view controller, you need to format it yourself.

Sample element: [https://sciencenotes.org/wp-content/uploads/2015/04/06-Carbon-Tile.png](https://sciencenotes.org/wp-content/uploads/2015/04/06-Carbon-Tile.png)

## Endpoints

**Elements**

```
GET https://5c1d79abbc26950013fbcaa9.mockapi.io/api/v1/elements
```

This is a public read-only GET endpoint so no authentication is necessary.

**Images**

```
Thumbnail (for table view): http://www.theodoregray.com/periodictable/Tiles/{ElementIDWithThreeDigits}/s7.JPG
Example: http://www.theodoregray.com/periodictable/Tiles/018/s7.JPG

Full-size: (for detail view): http://images-of-elements.com/{lowercasedElementName}.jpg
Example: http://images-of-elements.com/argon.jpg
```

Use the file naming convention illustrated here to generate urls for images.

These are both http urls, so you will need change your info.plist to [allow arbitrary loads](https://stackoverflow.com/questions/31254725/transport-security-has-blocked-a-cleartext-http).

No full size images are available for atomic numbers 90 and up. You can use a placeholder image

**Favorites**

```
POST https://5d83bc5ebaffda001476aa88.mockapi.io/api/v1/favorites
```

This endpoint expects JSON with the following keys: "favoritedBy", "elementName" and "elementSymbol".
Values should be your own name, and the symbol and name of the element currently displayed by the detail page, respectively.

Using Postman and the endpoint below verify that you have favorited an element. 

*****Note that the domain name for this endpoint is different than the one above.*****
```
GET https://5d83bc5ebaffda001476aa88.mockapi.io/api/v1/favorites
```

## Bonus 

Get all favorites endpoint
```
GET https://5d83bc5ebaffda001476aa88.mockapi.io/api/v1/favorites
```

Embed your ElementsViewController in a Tab Bar controller that has 2 viewcontrollers that includes the ElementsViewController. The first view controller should display the Elements. The second view controller should display only the Elements you have favorited. (Hint: filter{} using favoritedBy: "Your name")

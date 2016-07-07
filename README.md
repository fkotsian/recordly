# Recordly

## Approach

I started by assessing the requirements for this project. The requirements that stuck out to me were:

- user authentication
- search (I assumed by album or song)
- forms to submit albums and songs (a nested form)
- the ability to favorite albums and songs
- various views of the albums and songs, including favorited ones

I then thought about the data model. A few things became evident:
- songs belonged to albums
- albums belonged to artists
- albums, songs, and artists could not be duplicated
- albums would have to somehow belong to either multiple users or to a different object (e.g. a Collection), which would itself belong to a User.

My thoughts were then to approach the requirements in the following order:
- authentication (since no data can be stored in the system without a logged in user)
- data model, including nested forms and views
- search (based on album and model name)
- favoriting, and associated views

I felt that this separated the parts of the project into composable chunks, and sequenced them according to dependencies.

## Steps

I started by implementing authentication, since all data in the system must come from user input. 

I chose the Clearance gem as a lightweight auth solution. Something like Devise provides the functionality we're after, but comes with a lot we don't need as well.

I'm a TDD'er, so I started with a failing feature spec for signing in. 
This drove out the need for various pieces:
- a User model
- sign up and sign in view
- session creation and deletion logic
- conditional display of the user's status to her ('Sign In'/'Sign Out' in the navbar)

I used Clearance's default views and controllers as boilerplate sign-in/sign-out logic, as I felt it fit the needs of the project.
I added a navbar and Bootstrap styles for ease, and added the conditional auth links in a partial.
At this point, the tests were passing.

## Next Steps

Having completed the Authentication feature and given myself the backbone of the application, I would start next with the data model.

The data model has two interesting attributes:
- songs belong to albums, showing the need for a nested form
- many albums can belong to the same user, but albums (and songs) should not be duplicated in the database

To separate these concerns nicely, I would use a Collection object that belongs to a User and has many Albums.
This would allow us to separate the User ownership logic from the singleton-Album logic.

If I had more time to work on this project, I would then set up a nested form that would allow a user to submit an Album in his or her collection, as well as any Songs on the album.
The app would check if the album existed, create it if not, add it to the user's collection, and either find or create and associate the nested Songs and Artists with the Album.
I'd then set up the various collection views (#index), as well as the Album #show view (all songs on the album).

A few words on the remaining features:
- Search: Search would likely be a form implemented in the navbar that would search all the current users' Albums, Songs, and Artists for a given string. It would search these sequentially: if not found in Albums, it would search the titles of Songs, then the names of Artists.
- Favoriting: Favoriting would add a new boolean field, 'favorite', to albums, songs, and artists. This would be a checkbox when creating the object, as well as a star icon on any given view where favoriting is possible. I would implement a FavoritesController to manage displaying these objects, likely reusing the view partials for albums, songs, and artists in order to keep the views DRY.
- Styles: I'd add some Bootstrap styles to clean up the appearance for the collection views, single item views, and buttons.

I'd test any model logic and validations (e.g., uniqueness), and I'd test the nested forms to ensure that the correct objects were created and associated appropriately.


## Work planning (User Stories)
### HUP-1 : Creating a user (back) &#9745;
_As a user, I want to be able to create my own profile on the app._

__requirements :__ 
1. _At first start the user must be able to enter data such as his name to enter in the application._
2. _Those data must be stored locally in the application and can be re-used._
3. _There is no need to register its name at each start._

### HUP-2 : Getting notes (back) &#9745;
_As a user, I want to be able to read notes._

__requirements :__ 
1. _Possibility to read data from a json where notes are stored._
2. _Once those notes are taken, they must be stored in objects._

### HUP-3 : Editing and creating notes (back) &#9745;
_As a user, I want to be able to create and edit notes from the application._

__requirements :__
1. _Can edit those notes and change them permanently._
2. _Possibility to create as much notes as wanted._
3. _Initially the notes must be empty._
4. _Data are stored locally in a json file._

__to test :__
1. _Editing a note and verifying that the json file is well saved with the good data._
2. _Creating a note and verifying if it is empty with a normal status._

### HUP-4 : Deleting notes (back) &#9745;
_As a user, I want to be able to delete notes that I created._

__requirements :__
1. _Those notes must be deleted permanently._

__to test :__
1. _Deleting a note and verifying that the json file is well saved._

### HUP-5 : Light menu bar (front) &#9745;
_As a user, I want to be able to manage notes through a light menu bar._

__requirements :__
1. _There are those functionnalities :_
    > * _Creating note (unimplemented fully)_
    > * _Settings (unimplemented for now)_
2. _Needs to be light and beautiful._

### HUP-6 : Managing cards through different status (back) &#9745;
_As a user, I want to be able to move cards in different status._

__requirements :__
1. _There is different status :_
    > * _archived_
    > * _pinned_
    > * _normal_

__to test :__
1. _Methods that changes the status and verify that the file is well saved after._

### HUP-7 : Beautiful cards (front) &#9745;
_As a user, I want to see beautiful cards that I can move through different status._

__requirements :__
1. _Can choose actions while holding on the note :_
    > * _able to delete selection._
    > * _able to archive selection._
    > * _able to pin it._

### HUP-8 : Header Improvement (front) &#9745;
_As a user, I want to have a nice header with different functionnalities, that changes when I enter in selection mode._

__requirements :__
1. _When in normal mode I want to be able to :_
    > * _Create a new note (not implemented)._
    > * _~~Search a note by it's title.~~ : (maybe later) can create some bugs and is not that usefull._
    > * _Export and import data in or from a text file (not implemented)._
    > * _A toggle dark mode button (not implemented)._
2. _When in selection mode I want to be able to :_
    > * _Discard selection mode._
    > * _Add selected notes to archive, favorites or delete these._
    > * _Add a reminder parameter to selected notes (not implemented)._
    > * _Change a note's 'pastille' color._

### HUP-9 : Note Edition in Markdown (front) &#9745;
_As a user, I want to be able to edit the created notes easily and with markdown or rich text editor._

__requirements :__
1. _I can edit the notes with rich text editor / markdown._
2. _The notes are saved instantly when going back on the home page._
3. _There is an easy to use user interface._
4. _A popup button with markdown specifications can be use (help button)._

### HUP-10 : Export data in a json file (back) &#9744;

### HUP-11 : Import data from a json file (back) &#9744;

### HUP-12 : Dark and Light theme implementation (front) &#9744;

### HUP-13 : Application finalization &#9744;
_As a user, I want to have a nice app icon and I want to be able to download the app on my smartphone directly from the PlayStore._

__requirements :__
1. _There must be a code coverage of atleast 50%._

## Buffer (Other User Stories)
### HUP-config : Configuration file &#9745;
_As a programmer, I want to have a configuration file where I could store paths to files and other important data, in order to have all these informations stored in the same place._

### HUP-markdown : Take notes in markdown &#9744;
_As a user, I want to be able to write my notes in markdown, in order to have more formatting possibilities._

### HUP-export_import : Export and import notes &#9744;
_As a user, I want to be able to export my current notes to a .json file or get them from a .json file._

__requirements :__
1. _I can export my notes in a .json file that the user can manage._
1. _I can import new notes from a .json file._

## US that could be done
### HUP-XXX : Login Screen (front) &#9744;
_As a user, I must be able to create my own profile by entering :_
    > * _my name_

__requirements :__
1. _A beautiful and attractive login screen._

### HUP-XXX : Performance and optimization of the application (back - front) &#9744;
_As a user, I want an app that is Green and that does not require a lot of processor and memory use :_
    > * _Saving and writting data only when the app is closed._

### HUP-XXX : Note Reminder Implementation (back) &#9744;
_As a user, I want to be able to get notifications for specified notes in order to remember and learn faster what I wrote on the note._

__requirements :_
1. _The notification information is displayed on the note card as a Material experience._
2. _I can create notfications :_
    > * _Hourly_
    > * _Every 6 hours_
    > * _Daily_
    > * _Weekly_

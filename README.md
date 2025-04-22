# _Women at Yale: A Walking Tour_ Mobile App

 This is the source code of my CPSC 490 Senior Project at Yale University. This project is a mobile app supplement of the _Women at Yale: A Walking Tour_ project led by the Women's Faculty Forum (accessible [here](https://wff.yale.edu/resources/women-yale-walking-tour)) to inform participants of the history of women's contributions to the university. **Note that this app is only for demo and fundraising purposes and does not represent the university in any way.**

 ## Running the app

 ### Prerequisites 
 The app requires Flutter to be installed on your device.

 ### API Keys
 This app requires two API keys: Google Maps and Airtable. Create a file titled .env. Following the format of .env.example, insert your Airtable API key, GoogleMaps API key, and the url of your Airtable table as given in the API documentation for your table. 
 
 **Note: If you are building this app for web, you will need to make some changes**
  1. Title the file "dotenv" instead of .env.
  2. In the pubspec.yaml, change ".env" under assets to "dotenv"
  3. In the web/app.html file, insert your Google Maps API key after the equal sign in ```<script src="https://maps.googleapis.com/maps/api/js?key="></script>``` **Please note that this key is not secret and will be accessible to any user. Ensure your API key is [restricted](https://developers.google.com/maps/api-security-best-practices#restricting-api-keys) before using the key in production.**
 
 ### Steps to Run
 1. Clone the repository into your desired folder.
 2. cd into 'tour'
 3. Fill in API keys as described above.
 4. Run ```flutter pub get``` to get dependencies.
 5. Run ```flutter run``` to run the app. Note that you must select a device on which to run the app.

 

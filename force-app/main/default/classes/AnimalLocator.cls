public class AnimalLocator {

        public static string getAnimalNameById(Integer AnimalId) {
        Http http = new Http();
            
        HttpRequest request = new HttpRequest();
        request.setEndpoint('https://th-apex-http-callout.herokuapp.com/animals/' + AnimalId);
        request.setMethod('GET');
        HttpResponse response = http.send(request);
            
        string resultAnimalName='';
        System.debug('Response => '+ response.getStatusCode());
        System.debug('Response => '+ response.getBody());
            
        // If the request is successful, parse the JSON response.
        if (response.getStatusCode() == 200) {
            // Deserializes the JSON string into collections of primitive data types.
            Map<String, Object> results = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
            // Cast the values in the 'animals' key as a list
            
            //List<Object> animals = (List<Object>) results.get('animals');
            //System.debug('Received the following animals:');
            //for (Object animal: animals) {
            //    System.debug(animal);
            //}
                
            Map<string, object> animalsList = (map<string, object>) results.get('animal');
            System.debug('Received the following animals => '+animalsList);
            resultAnimalName=string.valueOf(animalsList.get('name'));
            System.debug('Animals =>' + resultAnimalName);
            
        }
        return resultAnimalName;
    }
    
}
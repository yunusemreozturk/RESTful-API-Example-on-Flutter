On this example, I used fake RESTful API. Before the run the project make sure configure all the fake RESTful API settings. 
  
  <h2>Getting started </h2>
	<h3>- [Install JSON Server] (https://github.com/typicode/json-server)</h3>

	npm install -g json-server 
			
	in the directory go to fake-json-server folder, open package.json and put your ip address
	"scripts": {
		"run-server": "json-server --host your-local-ip-address db.json"
	}, 
			
	npm run run-server 
	
	go to src -> service -> user_service.dart and put your ip address
	
	final String localUrl = 'http://your-ip-address:3000/users'; 

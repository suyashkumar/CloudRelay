/*
CloudRelay Firmware
Simple cloud controlled relay. 
Runs on a Spark Photon with a relay's control pin attached to D7.
*/
int control = D7;
int state=0; // Holds current state of the relay. 
void setup()
{
   pinMode(control, OUTPUT); // Configure control as output pin
   Spark.function("led",ledToggle); // Register toggling function with the Spark service

}

void loop()
{
   // Nothing to do here
}

/*
ledToggle()
Toggles LED lights attached to relay. Command passed from RESTful POST request determines 
whether a toggle actually occurs or whether just the current state of the relay is returned 
in the request.
@param String command:  either "toggle" or "status" to toggle the relay or to just query the status (respectivly)
@returns int status:    either 1 or 0 for on or off (current state after executing request). -1 for bad command.
*/
int ledToggle(String command) {
    if (command=="toggle") {
        if (state==0){
            digitalWrite(control,HIGH); // Set relay on
            state=1; // Update state
            return 1; // Return on
        }
        else if (state==1){
            digitalWrite(control,LOW); // Set relay off
            state=0; // Set state to off
            return 0; // Return off
        }
    }
    else if(command=="status"){
        return state; // Just return the current state 
    }
    else {
        return -1; // Unrecognized command 
    }
}

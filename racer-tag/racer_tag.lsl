// sl-racesystem
// MIT License
// Object: Racer Tag
// Description: Attachable object representing a racer

integer CHANNEL = -912387;

string vehicleName = "";
string vehicleColor = "";

integer racing = FALSE;
integer currentCheckpoint = 0;
float raceStartTime;

default
{
    state_entry()
    {
        llOwnerSay("Racer Tag attached. Touch to configure.");
        llListen(CHANNEL, "", NULL_KEY, "");
    }

    touch_start(integer total)
    {
        if (llDetectedKey(0) == llGetOwner())
        {
            if (vehicleName == "")
                llTextBox(llGetOwner(), "Enter vehicle name:", CHANNEL);
            else if (vehicleColor == "")
                llTextBox(llGetOwner(), "Enter vehicle color:", CHANNEL);
            else
                llOwnerSay("Racer already configured.");
        }
    }

    listen(integer ch, string name, key id, string msg)
    {
        list data = llParseString2List(msg, ["|"], []);
        string cmd = llList2String(data, 0);

        // Configuration input
        if (cmd == "")
        {
            if (vehicleName == "")
            {
                vehicleName = msg;
            }
            else if (vehicleColor == "")
            {
                vehicleColor = msg;
                llOwnerSay("Configured: " + vehicleName + " (" + vehicleColor + ")");
                llRegionSay(CHANNEL,
                    "JOIN|" + (string)llGetOwner() + "|" + vehicleName + "|" + vehicleColor
                );
            }
        }

        // Start race
        if (cmd == "START" && (key)llList2String(data,1) == llGetOwner())
        {
            racing = TRUE;
            currentCheckpoint = 0;
            raceStartTime = llGetTime();
            llOwnerSay("Race started!");
        }

        // Finished
        if (cmd == "FINISHED" && (key)llList2String(data,1) == llGetOwner())
        {
            racing = FALSE;
            float total = llGetTime() - raceStartTime;
            llOwnerSay("Finished! Time: " + (string)total + "s");
        }
    }
}

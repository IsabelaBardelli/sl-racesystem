// sl-racesystem
// MIT License
// Object: Root Controller
// Description: Central race logic and ranking manager

integer EVT_START  = 100;
integer EVT_CP     = 200;
integer EVT_FINISH = 300;
integer EVT_SCORE  = 400;

integer CHANNEL = -912387;
integer MAX_RACERS = 10;
integer TOTAL_CPS = 3;

list racers;
// [avatarKey, currentCP, finished, finishTime]

float raceStartTime;
integer raceRunning = FALSE;

default
{
    state_entry()
    {
        racers = [];
        llListen(CHANNEL, "", NULL_KEY, "");
    }

    listen(integer ch, string name, key id, string msg)
    {
        list data = llParseString2List(msg, ["|"], []);
        if (llList2String(data,0) == "JOIN" && !raceRunning)
        {
            key av = (key)llList2String(data,1);

            if (llGetListLength(racers)/4 < MAX_RACERS)
            {
                racers += [av, 0, FALSE, 0.0];
                llOwnerSay("Racer joined: " + llKey2Name(av));
            }
        }
    }

    link_message(integer from, integer code, string msg, key sender)
    {
        if (code == EVT_START && !raceRunning)
        {
            startRace();
        }

        if (code == EVT_CP && raceRunning)
        {
            list d = llParseString2List(msg, ["|"], []);
            integer cp = (integer)llList2String(d,0);
            key av = (key)llList2String(d,1);
            handleCheckpoint(av, cp);
        }

        if (code == EVT_FINISH && raceRunning)
        {
            handleFinish((key)msg);
        }
    }
}

startRace()
{
    integer i;
    raceRunning = TRUE;
    raceStartTime = llGetTime();

    for (i = 0; i < llGetListLength(racers); i += 4)
    {
        llRegionSay(CHANNEL,
            "START|" + llList2String(racers,i)
        );
    }
}

handleCheckpoint(key av, integer cp)
{
    integer idx = llListFindList(racers, [av]);
    if (idx != -1)
    {
        integer current = llList2Integer(racers, idx+1);
        if (cp == current + 1)
        {
            racers = llListReplaceList(racers,
                [av, cp, FALSE, llList2Float(racers,idx+3)],
                idx, idx+3
            );
        }
    }
}

handleFinish(key av)
{
    integer idx = llListFindList(racers, [av]);
    if (idx != -1)
    {
        if (llList2Integer(racers, idx+1) == TOTAL_CPS)
        {
            float time = llGetTime() - raceStartTime;
            racers = llListReplaceList(racers,
                [av, llList2Integer(racers,idx+1), TRUE, time],
                idx, idx+3
            );
            llRegionSay(CHANNEL, "FINISHED|" + (string)av);
            updateScoreboard();
        }
    }
}

updateScoreboard()
{
    string text = "Race Results:\n";
    integer i;
    for (i = 0; i < llGetListLength(racers); i += 4)
    {
        if (llList2Integer(racers,i+2))
        {
            text += llKey2Name(llList2Key(racers,i)) +
                    " - " +
                    (string)llList2Float(racers,i+3) + "s\n";
        }
    }

    llMessageLinked(LINK_SET, EVT_SCORE, text, NULL_KEY);
}

// Displays race ranking

integer EVT_SCORE = 400;

default
{
    link_message(integer from, integer code, string msg, key sender)
    {
        if (code == EVT_SCORE)
        {
            llSetText(msg, <1,1,1>, 1.0);
        }
    }
}

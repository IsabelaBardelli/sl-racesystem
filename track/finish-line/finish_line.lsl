// Finish line trigger

default
{
    collision_start(integer total)
    {
        integer i;
        for (i = 0; i < total; i++)
        {
            llMessageLinked(
                LINK_ROOT,
                300,
                (string)llDetectedKey(i),
                llGetKey()
            );
        }
    }
}

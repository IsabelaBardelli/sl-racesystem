// Generic checkpoint script

integer CHECKPOINT_ID = 1;

default
{
    collision_start(integer total)
    {
        integer i;
        for (i = 0; i < total; i++)
        {
            llMessageLinked(
                LINK_ROOT,
                200,
                (string)CHECKPOINT_ID + "|" + (string)llDetectedKey(i),
                llGetKey()
            );
        }
    }
}

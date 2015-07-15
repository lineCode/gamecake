/*+-----------------------------------------------------------------------------------------------------------------+*/
//
// (C) Kriss@XIXs.com 2013
//
/*+-----------------------------------------------------------------------------------------------------------------+*/
#include "all.h"




/*+-----------------------------------------------------------------------------------------------------------------+*/
//
// allocate a key
//
/*+-----------------------------------------------------------------------------------------------------------------+*/
bool t3d_key::setup(void)
{
	DMEM_ZERO(this);

	return true;
}

/*+-----------------------------------------------------------------------------------------------------------------+*/
//
// reset a key
//
/*+-----------------------------------------------------------------------------------------------------------------+*/
bool t3d_key::reset(void)
{

	clean();
	return setup();
}

/*+-----------------------------------------------------------------------------------------------------------------+*/
//
// free a key
//
/*+-----------------------------------------------------------------------------------------------------------------+*/
void t3d_key::clean(void)
{
}

/*+-----------------------------------------------------------------------------------------------------------------+*/
//
// allocate an key
//
/*+-----------------------------------------------------------------------------------------------------------------+*/
t3d_key *thunk3d::AllocKey(void)
{
t3d_key *ret;


	if(!(ret=(t3d_key *)keys->alloc()))
	{
		DBG_Error("Failed to allocate thunk3D.key.\n");
		goto bogus;
	}

	if(!ret->setup())
	{
		DBG_Error("Failed to setup thunk3D.key.\n");
		goto bogus;
	}

	DLIST_PASTE(keys->atoms->last,ret,0);

	return ret;

bogus:
	FreeKey(ret);
	return 0;
}

/*+-----------------------------------------------------------------------------------------------------------------+*/
//
// free an key
//
/*+-----------------------------------------------------------------------------------------------------------------+*/
void thunk3d::FreeKey(t3d_key *key)
{
	if(key)
	{
		DLIST_CUT(key);

		key->clean();

		keys->free((llatom*)key);
	}
}

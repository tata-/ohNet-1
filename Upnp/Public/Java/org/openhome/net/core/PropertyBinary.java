package org.openhome.net.core;

import ohnet.Parameter;

import org.openhome.net.controlpoint.IPropertyChangeListener;

/**
 * Binary type property.  Only intended for use by auto-generated proxies and providers.
 */
public class PropertyBinary extends Property
{
	private static native long ServicePropertyCreateBinaryCp(String aName, IPropertyChangeListener aListener);
	private static native long ServicePropertyCreateBinaryDv(long aParameter);
	private static native byte[] ServicePropertyGetValueBinary(long aProperty);
	private static native int ServicePropertySetValueBinary(long aProperty, byte[] aValue, int aLen);
	
	/**
	 * Constructor suitable for use by clients of the control point stack.
	 * 
	 * @param aName		property name.
	 * @param aListener action to run when the property's value changes.
	 */
	public PropertyBinary(String aName, IPropertyChangeListener aListener)
	{
		super(aListener);
		iHandle = ServicePropertyCreateBinaryCp(aName, aListener);
	}
	
	/**
	 * Constructor suitable for use by clients of the device stack.
	 * Assumes the managed property does not own the underlying native property.
	 * 
	 * @param aParameter	parameter defining the name for the property.
	 */
	public PropertyBinary(Parameter aParameter)
	{
		super(false);
		iHandle = ServicePropertyCreateBinaryDv(aParameter.getHandle());
	}
	
	/**
	 * Constructor suitable for use by clients of the device stack.
	 * 
	 * @param aParameter			parameter defining the name for the property.
	 * @param aOwnsNativeProperty	whether the managed property owns the underlying native property.
	 */
	public PropertyBinary(Parameter aParameter, boolean aOwnsNativeProperty)
	{
		super(aOwnsNativeProperty);
		iHandle = ServicePropertyCreateBinaryDv(aParameter.getHandle());
	}
	
	/**
	 * Query the value of the property.
	 * 
	 * @return	binary property value.
	 */
	public byte[] getValue()
	{
		return ServicePropertyGetValueBinary(iHandle);
	}
	
	/**
	 * Set the value of the property.
	 * 
	 * @param aValue	new value for the property.
	 * @return			{@code true} if the property's value was changed;
	 * 					{@code false} otherwise.
	 */
	public boolean setValue(byte[] aValue)
	{
		int changed = ServicePropertySetValueBinary(iHandle, aValue, aValue.length);
		
		return (changed != 0);
	}
}
#ifndef HEADER_ZAPPORGTESTWIDGETCONTROLLER1
#define HEADER_ZAPPORGTESTWIDGETCONTROLLER1

#include <ZappTypes.h>
#include <Buffer.h>
#include <Exception.h>
#include <Functor.h>
#include <FunctorAsync.h>
#include <CpProxy.h>

namespace Zapp {

class CpDevice;
class Action;
class PropertyBinary;
class PropertyBool;
class PropertyInt;
class PropertyString;
class PropertyUint;

/**
 * Proxy for zapp.org:TestWidgetController:1
 * @ingroup Proxies
 */
class CpProxyZappOrgTestWidgetController1 : public CpProxy
{
public:
    /**
     * Constructor.
     *
     * Use CpProxy::[Un]Subscribe() to enable/disable querying of state variable
     * and reporting of their changes.
     *
     * @param[in]  aDevice   The device to use
     */
    CpProxyZappOrgTestWidgetController1(CpDevice& aDevice);
    /**
     * Destructor.
     * If any asynchronous method is in progress, this will block until they complete.
     * [Note that any methods still in progress are likely to complete with an error.]
     * Clients who have called Subscribe() do not need to call Unsubscribe() before
     * calling delete.  An unsubscribe will be triggered automatically when required.
     */
    ~CpProxyZappOrgTestWidgetController1();

    /**
     * Invoke the action synchronously.  Blocks until the action has been processed
     * on the device and sets any output arguments.
     *
     * @param[in]  aWidgetUdn
     * @param[in]  aWidgetClass
     */
    void SyncCreateWidget(const Brx& aWidgetUdn, TUint aWidgetClass);
    /**
     * Invoke the action asynchronously.
     * Returns immediately and will run the client-specified callback when the action
     * later completes.  Any output arguments can then be retrieved by calling
     * EndCreateWidget().
     *
     * @param[in] aWidgetUdn
     * @param[in] aWidgetClass
     * @param[in] aFunctor   Callback to run when the action completes.
     *                       This is guaranteed to be run but may indicate an error
     */
    void BeginCreateWidget(const Brx& aWidgetUdn, TUint aWidgetClass, FunctorAsync& aFunctor);
    /**
     * Retrieve the output arguments from an asynchronously invoked action.
     * This may only be called from the callback set in the above Begin function.
     *
     * @param[in]  aAsync  Argument passed to the callback set in the above Begin function
     */
    void EndCreateWidget(IAsync& aAsync);

    /**
     * Invoke the action synchronously.  Blocks until the action has been processed
     * on the device and sets any output arguments.
     *
     * @param[in]  aWidgetUdn
     */
    void SyncRemoveWidget(const Brx& aWidgetUdn);
    /**
     * Invoke the action asynchronously.
     * Returns immediately and will run the client-specified callback when the action
     * later completes.  Any output arguments can then be retrieved by calling
     * EndRemoveWidget().
     *
     * @param[in] aWidgetUdn
     * @param[in] aFunctor   Callback to run when the action completes.
     *                       This is guaranteed to be run but may indicate an error
     */
    void BeginRemoveWidget(const Brx& aWidgetUdn, FunctorAsync& aFunctor);
    /**
     * Retrieve the output arguments from an asynchronously invoked action.
     * This may only be called from the callback set in the above Begin function.
     *
     * @param[in]  aAsync  Argument passed to the callback set in the above Begin function
     */
    void EndRemoveWidget(IAsync& aAsync);

    /**
     * Invoke the action synchronously.  Blocks until the action has been processed
     * on the device and sets any output arguments.
     *
     * @param[in]  aWidgetUdn
     * @param[in]  aRegisterIndex
     * @param[in]  aRegisterValue
     */
    void SyncSetWidgetRegister(const Brx& aWidgetUdn, TUint aRegisterIndex, TUint aRegisterValue);
    /**
     * Invoke the action asynchronously.
     * Returns immediately and will run the client-specified callback when the action
     * later completes.  Any output arguments can then be retrieved by calling
     * EndSetWidgetRegister().
     *
     * @param[in] aWidgetUdn
     * @param[in] aRegisterIndex
     * @param[in] aRegisterValue
     * @param[in] aFunctor   Callback to run when the action completes.
     *                       This is guaranteed to be run but may indicate an error
     */
    void BeginSetWidgetRegister(const Brx& aWidgetUdn, TUint aRegisterIndex, TUint aRegisterValue, FunctorAsync& aFunctor);
    /**
     * Retrieve the output arguments from an asynchronously invoked action.
     * This may only be called from the callback set in the above Begin function.
     *
     * @param[in]  aAsync  Argument passed to the callback set in the above Begin function
     */
    void EndSetWidgetRegister(IAsync& aAsync);

    /**
     * Invoke the action synchronously.  Blocks until the action has been processed
     * on the device and sets any output arguments.
     *
     * @param[in]  aWidgetUdn
     * @param[in]  aRegisterIndex
     * @param[out] aRegisterValue
     */
    void SyncGetWidgetRegister(const Brx& aWidgetUdn, TUint aRegisterIndex, TUint& aRegisterValue);
    /**
     * Invoke the action asynchronously.
     * Returns immediately and will run the client-specified callback when the action
     * later completes.  Any output arguments can then be retrieved by calling
     * EndGetWidgetRegister().
     *
     * @param[in] aWidgetUdn
     * @param[in] aRegisterIndex
     * @param[in] aFunctor   Callback to run when the action completes.
     *                       This is guaranteed to be run but may indicate an error
     */
    void BeginGetWidgetRegister(const Brx& aWidgetUdn, TUint aRegisterIndex, FunctorAsync& aFunctor);
    /**
     * Retrieve the output arguments from an asynchronously invoked action.
     * This may only be called from the callback set in the above Begin function.
     *
     * @param[in]  aAsync  Argument passed to the callback set in the above Begin function
     * @param[out] aRegisterValue
     */
    void EndGetWidgetRegister(IAsync& aAsync, TUint& aRegisterValue);


private:
private:
    Action* iActionCreateWidget;
    Action* iActionRemoveWidget;
    Action* iActionSetWidgetRegister;
    Action* iActionGetWidgetRegister;
};

} // namespace Zapp

#endif // HEADER_ZAPPORGTESTWIDGETCONTROLLER1

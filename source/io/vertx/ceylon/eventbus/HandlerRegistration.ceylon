import io.vertx.ceylon.util { AsyncResultPromise }
import org.vertx.java.core { Handler_=Handler }
import ceylon.promise { Promise }
import io.vertx.ceylon { Registration }
import java.lang { Void_=Void }
import org.vertx.java.core.eventbus { Message_=Message, EventBus_=EventBus }
import io.vertx.ceylon.interop { EventBusAdapter { registerHandler_=registerHandler, unregisterHandler_=unregisterHandler } }

by("Julien Viet")
class HandlerRegistration<M>(EventBus_ delegate, String address, Anything(Message<M>) handler)
        extends AbstractMessageAdapter<M>()
        satisfies Registration & Handler_<Message_<Object>> {
    
    value resultHandler = AsyncResultPromise<Null, Void_>((Void_ s) => null);
    shared actual Promise<Null> completed = resultHandler.promise;
    
    shared actual Promise<Null> cancel() {
        value resultHandler = AsyncResultPromise<Null, Void_>((Void_ s) => null);
        unregisterHandler_(delegate, address, this, resultHandler);
        return resultHandler.promise;
    }
    
    shared void register() {
        registerHandler_(delegate, address, this, resultHandler);
    }
    
    shared actual void dispatch(Message<M> message) {
        handler(message);
    }
    
    shared actual void reject(Object? body) {
        // ????
    }
}

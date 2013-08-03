/*
 * Copyright 2013 Julien Viet
 *
 * Licensed under the Apache License, Version 2.0 (the "License");
 * you may not use this file except in compliance with the License.
 * You may obtain a copy of the License at
 *
 *     http://www.apache.org/licenses/LICENSE-2.0
 *
 * Unless required by applicable law or agreed to in writing, software
 * distributed under the License is distributed on an "AS IS" BASIS,
 * WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
 * See the License for the specific language governing permissions and
 * limitations under the License.
 */
import vietj.vertx { toMap }
import vietj.promises { Promise }
import org.vertx.java.core.http { HttpClientResponse_=HttpClientResponse }

by "Julien Viet"
license "ASL2"
shared class HttpClientResponse(HttpClientResponse_ delegate) extends HttpInput() {
	
	shared Integer status => delegate.statusCode();
	
	doc "The http headers"
	shared actual Map<String,{String+}> headers = toMap(delegate.headers());
	
	// We must pause
	delegate.pause();
	
	shared actual Promise<Body> getBody<Body>(BodyType<Body> parser) {
		return parseBody(parser, delegate.bodyHandler, delegate, charset);
	}
}
 //
//  ZZUdp.m
//  PQAApp
//
//  Created by Avinash Tag on 12/02/16.
//  Copyright © 2016 Rohde & Schwarz. All rights reserved.
//

#import "ZZUdp.h"
#import "PQACommunicationChannel.h"

@interface ZZUdp ()



@end

@implementation ZZUdp


- (id) initServerOnPort:(UInt16)port delegateQueue:(dispatch_queue_t)queue connected:(void (^)(NSError **error))connected{
    
    
    DDLogInfo(@"------------------------UDP Thread initiated : %@-------------------------",queue);
    DDLogInfo(@"----- UDP server initialising with hostname : %@ , port : %hu -----",[[PQAApp sharedApplication].device currentIpaddress], port);
    if (self = [super init]){
        
        _socket = [[GCDAsyncUdpSocket alloc]initWithDelegate:self delegateQueue:queue];
        
        NSError *error = nil;
        if (![_socket bindToPort:port error:&error]){
            [_socket close];
            DDLogError(@"Socket closed as #error in connecting: %@",error.description);
            
        }
    }
    return self;
}

- (id) initToHost:(NSString *)hostname port:(UInt16)port delegateQueue:(dispatch_queue_t)queue completion:(void (^)(ZZUdp *client))completion{
    
    DDLogInfo(@"------------------------UDP Thread initiated : %@-------------------------",queue);
    DDLogInfo(@"----- UDP client initialising with hostname : %@ , port : %hu -----",hostname,port);
    if (self = [super init]){
        self.socket = [[GCDAsyncUdpSocket alloc]initWithDelegate:self delegateQueue:queue];
    }
    completion? completion(self):nil;
    return self;
}


- (void) startRecieving:(void (^)(NSError *error))recieving{
    NSError *error = nil;
    if (![_socket beginReceiving:&error]){
        DDLogError(@"ERROR to begin recieving: %@",error.description);
    }
    recieving ? recieving(error): nil;
}

- (void) setBandwidth:(NSNumber *)bandwidth resume:(void(^)())resume{
    [self.socket setBandwidth:bandwidth resume:resume];
}

- (void) closeAfterTimeInterval:(NSTimeInterval)timeInterval completed:(void (^)())completed{
    [self.socket closeAfterTimeInterval:timeInterval completed:completed];
}


- (void)sendDataToConnectedHost:(NSString *)host port:(UInt16)port data:(NSData *)data timeout:(NSTimeInterval)timeout tag:(long)tag{
        [_socket sendData:data toHost:host port:port withTimeout:timeout tag:tag];
   // DDLogInfo(@"#Send packetId %ld",tag);
}


+ (void) connectToHost:(NSString *)host onPort:(UInt16)port sendData:(NSData *)data timeout:(NSTimeInterval)timeout tag:(long)tag{

    GCDAsyncUdpSocket *socketlocal = [[GCDAsyncUdpSocket alloc]initWithDelegate:self delegateQueue:dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_BACKGROUND, 0)];
//    socketlocal setba
    [socketlocal sendData:data toHost:host port:port withTimeout:timeout tag:tag];
    DDLogInfo(@"udp data sent to %@ at port %hu packet length: %lu >>Stingformat: %@",host, port, (unsigned long)data.length, [[NSString alloc]initWithData:data encoding:NSUTF8StringEncoding]);
}


- (void) sendPacketIPERFWithId:(int)i data:(NSMutableData *)data{
    //    struct timeval packetTime;
    //    gettimeofday (&packetTime, NULL);
    
    struct UDP_datagram datagram ;
    datagram.idpacket = htonl(i);
    datagram.idpacketsss = 0;
    //    datagram.tv_sec = htonl(packetTime.tv_sec);
    //    datagram.tv_usec = htonl(packetTime.tv_usec);
    datagram.tv_sec = 0;
    datagram.tv_usec = 0;
    
    [data replaceBytesInRange:NSMakeRange(0, sizeof(datagram)) withBytes:&datagram];

    Expert *expert = [PQAApp sharedApplication].expert;
    [self sendDataToConnectedHost:expert.dauIp port:expert.portIPERFUplink.integerValue data:data timeout:1 tag:i];
}



- (void) didConnectToHost:(UDPSocketDidConnect)didconnect{
    _socketdidConnect = didconnect;
}

- (void) didSendData:(UDPSocketDidSendData)sendData{
    _socketDidSendData = sendData;
}

- (void) didReceiveData:(UDPSocketDidRecieveData)recieveData{
    _socketDidRecieveData = recieveData;
}

- (void) didClose:(UDPSocketDidClose)close{
    _socketDidClose = close;
}



#pragma mark - UDP Socket Delegates

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didConnectToAddress:(NSData *)address{
    
    _socketdidConnect ? self.socketdidConnect( [[NSString alloc]initWithData:address encoding:NSUTF8StringEncoding], nil) : nil;
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotConnect:(NSError *)error{
    _socketdidConnect ? self.socketdidConnect( nil, &error) : nil;
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didSendDataWithTag:(long)tag
{
    DDLogInfo(@"didSendDataWithTag delegate working");
    // You could add checks here
    _socketDidSendData ? self.socketDidSendData( tag, nil) : nil;
    if (_socketDidSendData) {
      //  DDLogInfo(@"didSendDataWithTag Block Exist");
    }
    //else
    // DDLogInfo(@"didSendDataWithTag Block nil");
}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didNotSendDataWithTag:(long)tag dueToError:(NSError *)error
{
    //DDLogInfo(@"didNotSendDataWithTag delegate working");

    // You could add checks here
    _socketDidSendData ? self.socketDidSendData( tag, error) : nil;
    if (_socketDidSendData) {
      //  DDLogInfo(@"didNotSendDataWithTag Block Exist");
    }
   // else
       // DDLogInfo(@"didNotSendDataWithTag Block nil");

}

- (void)udpSocket:(GCDAsyncUdpSocket *)sock didReceiveData:(NSData *)data
      fromAddress:(NSData *)address
withFilterContext:(id)filterContext
{
    _socketDidRecieveData ? self.socketDidRecieveData( data, address, filterContext) : nil;
    /*NSString *msg = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
     if (msg)
     {
     //[self logMessage:FORMAT(@"RECV: %@", msg)];
     }
     else
     {
     NSString *host = nil;
     uint16_t port = 0;
     [GCDAsyncUdpSocket getHost:&host port:&port fromAddress:address];
     
     //[self logInfo:FORMAT(@"RECV: Unknown message from: %@:%hu", host, port)];
     }*/
}

-(void) close{
    [_socket close];
//    _socket = nil;
}

- (void)dealloc{
    _socket = nil;
}

@end


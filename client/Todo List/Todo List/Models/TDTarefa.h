//
//  TDTarefa.h
//  Todo List
//
//  Created by Makoto Miyagawa on 9/5/14.
//  Copyright (c) 2014 Makoto Miyagawa. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TDTarefa : NSObject

@property (nonatomic, strong) NSNumber *idTarefa;
@property (nonatomic, strong) NSString *atividade;
@property (nonatomic, strong) NSNumber *concluido;

- (BOOL)isConcluido;
- (instancetype)initFromDictionary:(NSDictionary *)dict;
- (NSDictionary *)dictionaryRepresentation;

@end

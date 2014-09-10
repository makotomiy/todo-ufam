//
//  TDTarefa.m
//  Todo List
//
//  Created by Makoto Miyagawa on 9/5/14.
//  Copyright (c) 2014 Makoto Miyagawa. All rights reserved.
//

#import "TDTarefa.h"

@implementation TDTarefa

- (BOOL)isConcluido
{
    return [_concluido boolValue];
}

- (instancetype)initFromDictionary:(NSDictionary *)dict
{
    self = [self init];
    _idTarefa  = dict[@"id"];
    _atividade = dict[@"atividade"];
    _concluido = dict[@"concluido"];
    
    return self;
}

- (NSDictionary *)dictionaryRepresentation
{
    NSMutableDictionary *dict = [@{} mutableCopy];
    
    if (_idTarefa)  { dict[@"id"]        = _idTarefa; }
    if (_atividade) { dict[@"atividade"] = _atividade; }
    if (_concluido) { dict[@"concluido"] = _concluido; }
    
    return dict;
}

- (NSString *)description
{
    return [NSString stringWithFormat:@"Tarefa %d: %@", [_idTarefa integerValue], _atividade];
}

@end

fn exit(status: Int32) -> UInt8:
    return external_call["exit", UInt8, Int32](status)


def main():
    exit(0)

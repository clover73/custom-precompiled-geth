pragma solidity ^0.4.23;

contract HelloContract {

    function callPrecompiled () public {

        bytes memory input;
        input = "World";
        address prebuilt_addr = 0x64;
        uint input_len = input.length;
        uint256[1] memory output;
        
        assembly {
            //call contract at address a with input mem[in..(in+insize)) providing g gas and v wei and output area mem[out..(out+outsize)) returning 0 on error (eg. out of gas) and 1 on success
            //call(g, a, v, in, insize, out, outsize)   

            // call helloPrecompiled
            if iszero(call(not(0), prebuilt_addr, 0, input, input_len, output, 0x20)) {
                revert(0, 0)
            }
        }
    }

}
